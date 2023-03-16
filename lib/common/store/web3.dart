import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:dbook/common/key_manager/keystore_manager.dart';
import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../config/app_config.dart';

enum PublicChainType { bnb, polygon,filecoin }

enum CoinType { usdc }

enum AbiType { platform, nft, usdc }

class Web3Store extends GetxController {
  static Web3Store get to => Get.find();


  final gcDecimals = 18;

  // late int decimals;

  // late Web3Client client;
  late Web3Client bcsClient;
  late Web3Client fileCoinClient;
  late Web3Client polygonClient;

  late var contractJson;

  String? get _userAddress => UserStore.to.address;

  initClient() async {
    fileCoinClient = Web3Client(BlockChainConfig.FILECOIN_RPC, Client())..printErrors = true;
    bcsClient = Web3Client(BlockChainConfig.BSC_RPC, Client())..printErrors = true;
    polygonClient = Web3Client(BlockChainConfig.POLYGON_RPC, Client())..printErrors = true;
    contractJson = jsonDecode(await rootBundle.loadString(Assets.filesContract));
  }

  // 获取主链余额
  Future<String> getBalance(PublicChainType type) async {
    if (_userAddress == null) return '--';
    print('获取$type>>>$_userAddress>>>>>>的余额');

    try {
      EtherAmount amount = await _getClient(type).getBalance(EthereumAddress.fromHex(_userAddress!));
      BigInt available = amount.getInWei;
      String balance = (available / BigInt.from(pow(10, gcDecimals))).toString();
      print("=====" + balance);
      return _formatFour(balance);
    } catch (err) {
      print(' 余额错误: ${err.toString()}');
      return _formatFour('0.00');
    }
  }

  // 获取合约余额
  getTokenBalance(PublicChainType type) async {
    if (_userAddress == null) return '--';
    try {
      var result = await _ask(client: _getClient(type), deployedContract: _deployedContract(type, AbiType.usdc), func: 'balanceOf', param: [EthereumAddress.fromHex(_userAddress!)]);
      BigInt available = BigInt.parse(result.first.toString());
      int decimals = await _getDecimals(type);
      String balance = (available / BigInt.from(pow(10, decimals))).toString();
      print("=====" + balance);
      return _formatFour(balance);
    } catch (err) {
      print(' 余额错误: ${err.toString()}');
      return _formatFour('0.00');
    }
  }

  //region 发布书籍
  /// Step 0，调用NFT合约[isApprovedForAll]查看是否授权，若false转step 1，若true，转step 2；
  /// Step 1，调用NFT合约[setApprovalForAll]进行授权给platform合约，若成功，转step 2；
  /// tep 2，调用issue接口发布书籍。
  Future setApprovalForAll(PublicChainType type, pwd) async {
    var result = await _sendTransaction(
      client: _getClient(type),
      deployedContract: _deployedContract(type, AbiType.nft),
      func: 'setApprovalForAll',
      param: [contractAddress(AbiType.platform, type), true],
      pwd: pwd,
      isEIP1559: type == PublicChainType.filecoin,
    );
    logX.d('授权结果>>>>>>$result');
    return result;
  }

  Future<bool> isApprovedForAll(PublicChainType type) async {
    try {
      var result = await _ask(
          client: _getClient(type),
          deployedContract: _deployedContract(type, AbiType.nft),
          func: 'isApprovedForAll',
          param: [EthereumAddress.fromHex(_userAddress!), contractAddress(AbiType.platform, type)]);
      print(' isApprovedForAll-result: $result');
      return result.first;
    } catch (err) {
      print(' isApprovedForAll-ERROR: ${err.toString()}');
      return false;
    }
  }

  //endregion

  //region 购买首发
  Future payFirstTrade({required PublicChainType type, required int amount, required double price, required pwd}) async {
    var tradeValue = _toWei(amount * price);
    return await _sendTransaction(
      client: _getClient(type),
      deployedContract: _deployedContract(type, AbiType.platform),
      func: 'payFirstTrade',
      param: [tradeValue],
      pwd: pwd,
      isEIP1559: type == PublicChainType.filecoin,
    );
  }

  //endregion

  Future<String> setApprovalForTrade({required PublicChainType type, required num amount, required pwd}) async {
    var result = await _sendTransaction(
      client: _getClient(type),
      deployedContract: _deployedContract(type, AbiType.usdc),
      func: 'approve',
      param: [contractAddress(AbiType.platform, type), _toWei(amount)],
      pwd: pwd,
      isEIP1559: type == PublicChainType.filecoin,
    );
    return result.toString();
  }

  Future paySecondTrade({required PublicChainType chainType, required num tradeValue, required String? seller, required int? nftId, required nftAmount, required pwd}) async {
    var receiver = EthereumAddress.fromHex(_userAddress!);
    var client = _getClient(chainType);
    var fee = await getGasFee(chainType);

    var result = await _sendTransaction(
        client: client,
        deployedContract: _deployedContract(chainType, AbiType.platform),
        func: 'trade',
        param: [
          EthereumAddress.fromHex(seller ?? ''),
          receiver,
          BigInt.from(nftId ?? 0),
          BigInt.from(nftAmount),
          Uint8List.fromList([0x1234]),
          _toWei(tradeValue),
          _toWei(fee)
        ],
        pwd: pwd,
        isEIP1559: chainType == PublicChainType.filecoin,
    );
    logX.d('result>>>>>result: $result');
    return result;
  }

  // 获取手续费
  Future<double> getGasFee(PublicChainType type) async {
    EtherAmount gasPrice = await _getClient(type).getGasPrice();
    BigInt gasLimit = getGasLimit(type);

    BigInt gasFee = gasPrice.getInWei * gasLimit;
    var result = gasFee / BigInt.from(pow(10, gcDecimals));


    return result;
  }

  BigInt getGasLimit(PublicChainType type){
    BigInt gasLimit = BigInt.from(0);
    if (type == PublicChainType.bnb) {
      gasLimit = BlockChainConfig.BNB_GAS_PRICE ;
    } else if (type == PublicChainType.polygon) {
      gasLimit = BlockChainConfig.POLYGON_GAS_PRICE;
    }else if (type == PublicChainType.filecoin){
      gasLimit = BlockChainConfig.FILECOIN_GAS_PRICE;
    }
    return gasLimit;
  }

  Future<dynamic> getTradeFee(PublicChainType type) async {
    var result = await _ask(
      client: _getClient(type),
      deployedContract: _deployedContract(type, AbiType.platform),
      func: 'getFee',
      param: [],
    );
    return result.first;
  }

  PublicChainType? formatChainType(String? chainType) {
    if (chainType == 'bnb') {
      return PublicChainType.bnb;
    } else if (chainType == 'polygon') {
      return PublicChainType.polygon;
    } else if (chainType == 'filecoin') {
      return PublicChainType.filecoin;
    } else {
      return null;
    }
  }

  _toWei(num amount) {
    // 1 usdc = 1000000 wei
    return BigInt.from(amount * pow(10, 6));
  }

  Web3Client _getClient(PublicChainType type) {
    if (type == PublicChainType.bnb) {
      return bcsClient;
    } else if (type == PublicChainType.filecoin) {
      return fileCoinClient;
    } else{
      return polygonClient;
    }
  }

  getLog(String? address) async {
    print('获取log');
  }

  Future<int> _getDecimals(PublicChainType type) async {
    var result = await _ask(func: 'decimals', deployedContract: _deployedContract(type, AbiType.usdc), client: _getClient(type));
    return int.parse(result.first.toString());
  }

  Future<dynamic> _ask({required Web3Client client, required DeployedContract deployedContract, required String func, param}) async {
    logX.d('请求合约$func>>>>>>>deployedContract ${deployedContract.address} \nparam $param');
    try {
      final response = await client.call(
        contract: deployedContract,
        function: deployedContract.function(func),
        params: param ?? [],
      );
      return response;
    } catch (error) {
      print('调用合约失败: $error');
      return error.toString();
    }
  }

  Future<dynamic> _sendTransaction({required Web3Client client, required DeployedContract deployedContract, required String func, param, required pwd,bool isEIP1559 = false}) async {
    logX.d('请求合约$func>>>>>>>deployedContract ${deployedContract.address} \nparam $param');
    Credentials credentials = await Web3KeychainManager.getInstance().getCredentials(EthereumAddress.fromHex(_userAddress!), pwd);
    final networkId = await client.getNetworkId();
    EtherAmount gasPrice = await _getClient(PublicChainType.filecoin).getGasPrice();

    var transaction = Transaction.callContract(
      contract: deployedContract,
      function: deployedContract.function(func),
      parameters: param ?? [],
      maxFeePerGas: isEIP1559?gasPrice:null,
      maxPriorityFeePerGas: isEIP1559?gasPrice:null,
    );

    try {
      final response = await client.sendTransaction(credentials, transaction, chainId: networkId);
      logX.d('请求合约$func>>>>>>>response $response');
      return response;
    } catch (error) {
      print('调用合约失败: $error');
      return error.toString();
    }
  }

  //格式化小数点
  String _formatFour(String values) {
    double value = double.tryParse(values) ?? 0 / pow(10, gcDecimals);
    String newValue = value.toStringAsFixed(8);
    return _removeZero(newValue.substring(0, newValue.indexOf('.') + 7));
  }

  _removeZero(String value) {
    if (value.contains('.')) {
      value = value.replaceAll(RegExp(r"0+?$"), ""); //去掉后面无用的零
      value = value.replaceAll(RegExp(r"[.]$"), ""); //如小数点后面全是零则去掉小数点
    }
    return value;
  }

  DeployedContract _deployedContract(PublicChainType chainType, AbiType abiType) {
    return DeployedContract(ContractAbi.fromJson(jsonEncode(contractJson[abiType.name]), contractJson['contractName'] as String), contractAddress(abiType, chainType));
  }

  EthereumAddress contractAddress(AbiType abiType, PublicChainType chainType) {
    switch (abiType) {
      case AbiType.platform:
        if (chainType == PublicChainType.bnb)
          return EthereumAddress.fromHex(BlockChainConfig.BNB_PLATFORM_ADDRESS);
        else if (chainType == PublicChainType.polygon)
          return EthereumAddress.fromHex(BlockChainConfig.POLYGON_PLATFORM_ADDRESS);
        else if (chainType == PublicChainType.filecoin)
          return EthereumAddress.fromHex(BlockChainConfig.FILECOIN_PLATFORM_ADDRESS);
        else
          return EthereumAddress.fromHex('');
      case AbiType.usdc:
        if (chainType == PublicChainType.bnb)
          return EthereumAddress.fromHex(BlockChainConfig.BNB_USDC_ADDRESS);
        else if (chainType == PublicChainType.polygon)
          return EthereumAddress.fromHex(BlockChainConfig.POLYGON_USDC_ADDRESS);
        else if (chainType == PublicChainType.filecoin)
          return EthereumAddress.fromHex(BlockChainConfig.FILECOIN_USDC_ADDRESS);
        else
          return EthereumAddress.fromHex('');
      case AbiType.nft:
        if (chainType == PublicChainType.bnb)
          return EthereumAddress.fromHex(BlockChainConfig.BNB_NFT_ADDRESS);
        else if (chainType == PublicChainType.polygon)
          return EthereumAddress.fromHex(BlockChainConfig.POLYGON_NFT_ADDRESS);
        else if (chainType == PublicChainType.filecoin)
          return EthereumAddress.fromHex(BlockChainConfig.FILECOIN_NFT_ADDRESS);
        else
          return EthereumAddress.fromHex('');
      default:
        return EthereumAddress.fromHex('');
    }
  }

  @override
  void onInit() {
    initClient();
    super.onInit();
  }
}

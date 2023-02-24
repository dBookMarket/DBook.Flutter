import 'dart:convert';
import 'dart:math';

import 'package:dbook/common/key_manager/keystore_manager.dart';
import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

enum PublicChainType { bnb, polygon }

enum AbiType { platform, nft, usdc }

class Web3Store extends GetxController {
  static Web3Store get to => Get.find();
  final String BSC_RPC = 'https://endpoints.omniatech.io/v1/bsc/testnet/public';
  final String POLYGON_RPC = 'https://matic-mumbai.chainstacklabs.com';

  final String BNB_USDC_ADDRESS = '0x425F41d0F330021E72Ff70CB218fbD26559C509a';
  final String BNB_NFT_ADDRESS = '0xcf0b52b899Ac7ec7cfBdB022C2382bBb050C6Fc3';
  final String PLATFORM_BNB_ADDRESS = '0xc3a3cD2c77CE4a7c3aBee9f2eA9E37F058C5fbe8';

  final String POLYGON_USDC_ADDRESS = '0x93d633d2E5c2312A4d53f03C517C86563C9FC8fb';
  final String POLYGON_NFT_ADDRESS = '0x7C850235538410e46045873c6F7e86458F942136';
  final String PLATFORM_POLYGON_ADDRESS = '0xE344D7e81d04e77014f9e31423c59c8deb7f5Ff4';

  final gcDecimals = 18;

  // late int decimals;

  // late Web3Client client;
  late Web3Client bcsClient;
  late Web3Client polygonClient;

  late var contractJson;

  String? get _userAddress => UserStore.to.address;

  initClient() async {
    bcsClient = Web3Client(BSC_RPC, Client())..printErrors = true;
    polygonClient = Web3Client(POLYGON_RPC, Client())..printErrors = true;
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
      var result = await _ask(
          client: _getClient(type),
          deployedContract: _deployedContract(type, AbiType.usdc),
          func: 'balanceOf',
          param: [EthereumAddress.fromHex(_userAddress!)]);
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

  // 发布书籍每次都需要授权
  // Step 1，调用NFT合约setApprovalForAll()进行授权给platform合约，若成功，转step 2；
  // tep 2，调用issue接口发布书籍。
  setApprovalForAll(PublicChainType type) async {
    var result = await _askTransaction(
      client: _getClient(type),
      deployedContract: _deployedContract(type, AbiType.nft),
      func: 'setApprovalForAll',
      param: [_contractAddress(AbiType.platform, type), true],
    );
    logX.d('授权结果>>>>>>$result');
  }

  Future<bool> isApprovedForAll(PublicChainType type) async {
    try {
      var result = await _ask(
          client: _getClient(type),
          deployedContract: _deployedContract(type, AbiType.nft),
          func: 'isApprovedForAll',
          param: [EthereumAddress.fromHex(_userAddress!), _contractAddress(AbiType.platform, type)]);
      print(' isApprovedForAll-result: $result');
      return result.first;
    } catch (err) {
      print(' isApprovedForAll-ERROR: ${err.toString()}');
      return false;
    }
  }

  payFirstTrade({required PublicChainType type, required int amount, required double price}) async {
    var tradeValue = BigInt.from(amount * price);
    await _askTransaction(
      client: _getClient(type),
      deployedContract: _deployedContract(type, AbiType.platform),
      func: 'payFirstTrade',
      param: [_toWei(tradeValue)],
    );
  }

  PublicChainType? formatChainType(String chainType) {
    if (chainType == 'bnb') {
      return PublicChainType.bnb;
    } else if (chainType == 'polygon') {
      return PublicChainType.polygon;
    } else {
      return null;
    }
  }

  _toWei(BigInt amount) {
    // 1 usdc = 1000000 wei
    return amount * BigInt.from(pow(10, 6));
  }

  Web3Client _getClient(PublicChainType type) {
    if (type == PublicChainType.bnb) {
      return bcsClient;
    } else {
      return polygonClient;
    }
  }

  getLog(String? address) async {
    print('获取log');
  }

  Future<int> _getDecimals(PublicChainType type) async {
    var result =
        await _ask(func: 'decimals', deployedContract: _deployedContract(type, AbiType.usdc), client: _getClient(type));
    return int.parse(result.first.toString());
  }

  Future<dynamic> _ask(
      {required Web3Client client, required DeployedContract deployedContract, required String func, param}) async {
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

  Future<dynamic> _askTransaction(
      {required Web3Client client, required DeployedContract deployedContract, required String func, param}) async {
    logX.d('请求合约$func>>>>>>>deployedContract ${deployedContract.address} \nparam $param');
    Credentials credentials =
        await Web3KeychainManager.getInstance().getCredentials(EthereumAddress.fromHex(_userAddress!), '1');
    final networkId = await client.getNetworkId();

    var transaction = Transaction.callContract(
      contract: deployedContract,
      function: deployedContract.function(func),
      parameters: param ?? [],
    );
    try {
      final response = await client.sendTransaction(credentials, transaction,chainId: networkId);
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
    return DeployedContract(
        ContractAbi.fromJson(jsonEncode(contractJson[abiType.name]), contractJson['contractName'] as String),
        _contractAddress(abiType, chainType));
  }

  _contractAddress(AbiType abiType, PublicChainType chainType) {
    switch (abiType) {
      case AbiType.platform:
        if (chainType == PublicChainType.bnb)
          return EthereumAddress.fromHex(PLATFORM_BNB_ADDRESS);
        else if (chainType == PublicChainType.polygon)
          return EthereumAddress.fromHex(PLATFORM_POLYGON_ADDRESS);
        else
          return EthereumAddress.fromHex('');
      case AbiType.usdc:
        if (chainType == PublicChainType.bnb)
          return EthereumAddress.fromHex(BNB_USDC_ADDRESS);
        else if (chainType == PublicChainType.polygon)
          return EthereumAddress.fromHex(POLYGON_USDC_ADDRESS);
        else
          return EthereumAddress.fromHex('');
      case AbiType.nft:
        if (chainType == PublicChainType.bnb)
          return EthereumAddress.fromHex(BNB_NFT_ADDRESS);
        else if (chainType == PublicChainType.polygon)
          return EthereumAddress.fromHex(POLYGON_NFT_ADDRESS);
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
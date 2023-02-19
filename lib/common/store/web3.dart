import 'dart:convert';
import 'dart:math';

import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

enum PublicChainType { BSC, POLYGON }

enum AbiType { platform, nft, usdc }

class Web3Store extends GetxController {
  static Web3Store get to => Get.find();
  final String BSC_RPC = 'https://endpoints.omniatech.io/v1/bsc/testnet/public';
  final String POLYGON_RPC = 'https://matic-mumbai.chainstacklabs.com';

  final String BSC_TOKEN_ADDRESS = '0x425F41d0F330021E72Ff70CB218fbD26559C509a';
  final String POLYGON_TOKEN_ADDRESS = '0xeE4Fa11C6afd8002c539F653D3C75bB4C0467210';

  final gcDecimals = 18;
  late int decimals;
  late Web3Client client;
  late DeployedContract deployedContract;

  // 获取主链余额
  Future<String> getBalance(PublicChainType type, String? address) async {
    if (address == null) return '--';
    setContract(type);
    print('获取$type>>>$address>>>>>>的余额');

    try {
      EtherAmount amount = await client.getBalance(EthereumAddress.fromHex(address));
      BigInt available = amount.getInWei;
      String balance = (available / BigInt.from(pow(10, gcDecimals))).toString();
      print("=====" + balance);
      await client.dispose();
      return _formatFour(balance);
    } catch (err) {
      print(' 余额错误: ${err.toString()}');
      return _formatFour('0.00');
    }
  }

  // 获取合约余额
  getTokenBalance(PublicChainType type, String? address) async {
    if (address == null) return '--';
    await setContract(type);

    try {
      var result = await getBalanceOf(address);
      BigInt available = BigInt.parse(result.toString());
      String balance = (available / BigInt.from(pow(10, decimals))).toString();
      print("=====" + balance);
      await client.dispose();
      return _formatFour(balance);
    } catch (err) {
      print(' 余额错误: ${err.toString()}');
      return _formatFour('0.00');
    }
  }

  getLog(String? address) async {
    print('获取log');
    await setContract(PublicChainType.POLYGON);
    var result = await getContractCallBack(func: 'Transfer', param: ['', '', EthereumAddress.fromHex(address!)]);
    // TransactionInformation result = await client.getTransactionByHash('0x5744e52a13566668b17ff1578f2833740f22a7632756d448c7c3b0872361f52c');
    // var result = await client.getLogs(FilterOptions(address: EthereumAddress.fromHex('0x7c2F34beEAAb7ECD426D609e66a213C153bb1307'),fromBlock: BlockNum.current(),toBlock:BlockNum.pending()));
    logX.d(result);
  }

  setContract(PublicChainType type) async {
    if (type == PublicChainType.BSC) {
      client = Web3Client(BSC_RPC, Client());
      deployedContract = await getContractFunc(BSC_TOKEN_ADDRESS);
    } else {
      client = Web3Client(POLYGON_RPC, Client());
      deployedContract = await getContractFunc(POLYGON_TOKEN_ADDRESS);
    }
    decimals = await getDecimals();
  }

  Future<DeployedContract> getContractFunc(String contractAddress) async {
    return await fromAssets(Assets.filesContract, contractAddress);
  }

  Future<String> getBalanceOf(address) async {
    EthereumAddress mAddress = EthereumAddress.fromHex(address);
    return await getContractCallBack(func: 'balanceOf', param: [mAddress]);
  }

  Future<int> getDecimals() async {
    var result = await getContractCallBack(func: 'decimals');
    return int.parse(result.toString());
  }

  Future<String> getContractCallBack({required String func, param}) async {
    try {
      final response = await client.call(
        contract: deployedContract,
        function: deployedContract.function(func),
        params: param ?? [],
      );
      return response.first.toString();
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

  Future<DeployedContract> fromAssets(String path, String contractAddress) async {
    final contractJson = jsonDecode(await rootBundle.loadString(path));
    return DeployedContract(
        ContractAbi.fromJson(jsonEncode(contractJson['usdc']), contractJson['contractName'] as String),
        EthereumAddress.fromHex(contractAddress));
  }

  //格式化小数点
  String _formatFour(String values) {
    double value = double.tryParse(values) ?? 0 / pow(10, gcDecimals);
    String newValue = value.toStringAsFixed(8);
    return removeZero(newValue.substring(0, newValue.indexOf('.') + 7));
  }

  removeZero(String value) {
    if (value.contains('.')) {
      value = value.replaceAll(RegExp(r"0+?$"), ""); //去掉后面无用的零
      value = value.replaceAll(RegExp(r"[.]$"), ""); //如小数点后面全是零则去掉小数点
    }
    return value;
  }

  @override
  void onInit() {
    super.onInit();
  }
}

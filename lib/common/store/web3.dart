import 'dart:convert';
import 'dart:math';

import 'package:dbook/generated/assets.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Web3Store extends GetxController {
  static Web3Store get to => Get.find();
  final String rpcUrl = 'https://matic-mumbai.chainstacklabs.com';
  late String _contractAddress;
  late DeployedContract contract;
  final gcDecimals = 6;
  late int decimals;

  late Web3Client client;

  // DeployedContract contract;
  // String _contractAddress;
  // int decimals;

//获取主链余额
  Future<String> getBalance(String address) async {
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

  //
  //判断是否合约地址
  //contractAddress 合约地址
  //
  Future<bool> getIsContractAddress(String contractAddress) async {
    if (contractAddress.length != 42) {
      return false;
    } else {
      EthereumAddress address = EthereumAddress.fromHex(contractAddress);
      var respons = await client.getCode(address);
      print("respons ====" + respons.toString());
      return respons.length > 0 ? true : false;
    }
  }

  setContract(String contractAddress) async {
    _contractAddress = contractAddress;
    contract = await fromAssets(
        Assets.filesContract, _contractAddress);
    var result = await getContractInfo('decimals');
    decimals = int.parse(result.toString());
    print("==精度获取==" + decimals.toString());
  }

  Future<String> getContractInfo(String functionName) async {
    try {
      final response = await client.call(
        contract: contract,
        function: contract.function(functionName),
        params: [],
      );
      print(response.first.toString());
      return response.first.toString();
    } catch (error) {
      print(error);
      return error.toString();
    }
  }


  Future<DeployedContract> fromAssets(
      String path, String contractAddress) async {
    final contractJson =
    jsonDecode(await rootBundle.loadString(path));
    return DeployedContract(ContractAbi.fromJson(jsonEncode(contractJson['abi']),contractJson['contractName'] as String),
        EthereumAddress.fromHex(contractAddress));
  }

  //获取合约余额
  Future<String> getTokenBalance(String mAddress) async {
    await setContract('0xeE4Fa11C6afd8002c539F653D3C75bB4C0467210');
    EthereumAddress address = EthereumAddress.fromHex(mAddress);
    final response = await client.call(
      contract: contract,
      function: contract.function('balanceOf'),
      params: [address],
    );
    print('response===='+response.toString());
    String balance = (response.first / BigInt.from(pow(10, decimals))).toString();
    print('====' + balance);
    return _formatFour(balance);
  }

  //格式化小数点
  String _formatFour(String values) {
    double value = double.tryParse(values) ?? 0 / pow(10, gcDecimals);
    String newValue = value.toStringAsFixed(8);
    return newValue.substring(0, newValue.indexOf('.') + 7);
  }

  @override
  void onInit() {
    client = Web3Client(rpcUrl, Client());
    super.onInit();
  }
}

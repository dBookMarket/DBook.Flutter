// import 'dart:convert';
// import 'dart:math';
// import 'dart:typed_data';
//
// import 'package:bip39/bip39.dart' as bip39;
// import 'package:bip32/bip32.dart' as bip32;
// import 'package:hex/hex.dart';
// import 'package:web3dart/credentials.dart';
// import 'package:web3dart/crypto.dart';
//
// //导入助记词
// Future<void> importMnemonic(String mnemonic, String walletname, String password) async {
//   print('助记词====      ' + mnemonic);
//   String seed = bip39.mnemonicToSeedHex(mnemonic);
//   print('seed====    ' + seed);
//   var root = bip32.BIP32.fromSeed(encode(seed));
//   var child = root.derivePath("m/44'/60'/0'/0/0");
//   String privateKey = '0x' + UTF8.encode(child.privateKey);
//   print("私钥:" + privateKey);
//   // String privateKey ='0x'+ bytesToHex(child.privateKey);
//   // print("公钥:" + bytesToHex(child1.publicKey));
//   EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
//   EthereumAddress address = await credentials.extractAddress();
//   String mAddress = address.hexEip55;
//   print("地址   ====   " + mAddress);
//   var random = Random();
//   Wallet wallet = Wallet.createNew(credentials, password, random);
//   String keystore = wallet.toJson();
//   print("keystore==== " + keystore);
//
// }
//
// //导入keystore
// Future<void> importKeyStore(String keystore, String walletname, String password) async {
//   print('解析keystore====     ' + keystore);
//   Wallet wallet = Wallet.fromJson(keystore, password);
//   EthereumAddress address = await wallet.privateKey.extractAddress();
//   String mAddress = address.hexEip55;
//   print("地址   ====   " + mAddress);
//   String privateKey = bytesToHex(wallet.privateKey.privateKey);
//   print("私钥====     " + privateKey);
// }
//
// //导入私钥
// Future<void> importPrivate( String mprivate, String walletname, String password) async {
//   print('私钥====     ' + mprivate);
//   Credentials credentials = EthPrivateKey.fromHex(mprivate);
//   EthereumAddress address = await credentials.extractAddress();
//   String mAddress = address.hexEip55;
//   print("地址   ====   " + mAddress);
//   var random = new Random.secure();
//   Wallet wallet = Wallet.createNew(credentials, password, random);
//   String keystore = wallet.toJson();
//   print("keystore====     " + keystore);
// }
//
// Uint8List encode(String s) {
//   var encodedString = utf8.encode(s);
//   var encodedLength = encodedString.length;
//   var data = ByteData(encodedLength + 4);
//   data.setUint32(0, encodedLength, Endian.big);
//   var bytes = data.buffer.asUint8List();
//   bytes.setRange(4, encodedLength + 4, encodedString);
//   return bytes;
// }

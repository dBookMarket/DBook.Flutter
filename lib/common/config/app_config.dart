
import 'package:flutter_screenutil/flutter_screenutil.dart';

///设计尺寸
class ScreenConfig{
  static final double designW = 750;
  static final double designH = 1334;
  static final double appBarHeight = 80.h;
  static final double marginH = 40.h;

}

class ScanConfig{
  static final String bnb = 'https://testnet.bscscan.com/tx/';
  static final String polygon = 'https://mumbai.polygonscan.com/tx/';
  static final String fileCoin = 'https://hyperspace.filfox.info/en/message/';
}

class BlockChainConfig{
  static final String FILECOIN_RPC = 'https://api.hyperspace.node.glif.io/rpc/v1';
  static final String BSC_RPC = 'https://endpoints.omniatech.io/v1/bsc/testnet/public';
  static final String POLYGON_RPC = 'https://matic-mumbai.chainstacklabs.com';

  static final String BNB_USDC_ADDRESS = '0x425F41d0F330021E72Ff70CB218fbD26559C509a';
  static final String BNB_NFT_ADDRESS = '0xcf0b52b899Ac7ec7cfBdB022C2382bBb050C6Fc3';
  static final String BNB_PLATFORM_ADDRESS = '0xc3a3cD2c77CE4a7c3aBee9f2eA9E37F058C5fbe8';

  static final String POLYGON_USDC_ADDRESS = '0x93d633d2E5c2312A4d53f03C517C86563C9FC8fb';
  static final String POLYGON_NFT_ADDRESS = '0x7C850235538410e46045873c6F7e86458F942136';
  static final String POLYGON_PLATFORM_ADDRESS = '0xE344D7e81d04e77014f9e31423c59c8deb7f5Ff4';

  static final String FILECOIN_USDC_ADDRESS = '0x3cF2C8f435f243d965037672182A982B2b006fc9';
  static final String FILECOIN_NFT_ADDRESS = '0xf55f35F0e2848cefc71724d99930c3495144e9f3';
  static final String FILECOIN_PLATFORM_ADDRESS = '0xbF6c659e7a917807d2FdAcBC68329088686c4A6B';


  static final BigInt BNB_GAS_PRICE = BigInt.from(45447);
  static final BigInt POLYGON_GAS_PRICE = BigInt.from(59597);
  static final BigInt FILECOIN_GAS_PRICE = BigInt.from(59597);
}

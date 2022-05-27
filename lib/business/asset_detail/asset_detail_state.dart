import 'package:dbook/generated/assets.dart';
import 'package:get/get.dart';

class AssetDetailState {
  late final int id;
  final currentIndex = 1.obs;
  AssetDetailState() {
    id = Get.arguments?['id']??'';
  }
  final images = <String>[].obs;

  // List<String> imageTemp = [
  //   'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1114%2F062021132H5%2F210620132H5-1-1200.jpg&refer=http%3A%2F%2Fimg.jj20'
  //       '.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654761426&t=a24f8b58b2ac42ca3c7fa2d5038c7dba',
  //   'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic%2F09%2F3a%2Fbc%2F093abce7b31f4c8ffdbf345375ff4abb.jpg&refer=http%3A%2F%2Fup.enterdesk'
  //       '.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654761426&t=9da6e299433f2a4358c49b721a091f0b',
  //   'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1115%2F101021113337%2F211010113337-6-1200.jpg&refer=http%3A%2F%2Fimg.jj20'
  //       '.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654761426&t=fe1834f2474fd7f1debf7b1787d68cdf',
  //   'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202109%2F06%2F20210906225922_1c31b.thumb.1000_0.jpeg&refer=http%3A%2F%2Fc-ssl'
  //       '.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654761426&t=289daa2266f019507145bb4f189d9614',
  //   'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1115%2F101021113337%2F211010113337-2-1200.jpg&refer=http%3A%2F%2Fimg.jj20'
  //       '.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654761426&t=f3f74400737c74eb2a2dd51beb9a6f3d',
  //   'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F4k%2Fs%2F02%2F21092422292J5A-0-lp.jpg&refer=http%3A%2F%2Fimg.jj20'
  //       '.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654761426&t=c30aa9c4225d31a87b2a4e3235732ca0',
  //   'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F201902%2F23%2F20190223231014_csxbp.thumb.400_0.jpg&refer=http%3A%2F%2Fc-ssl'
  //       '.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654761426&t=6503cbaf4f2528261c7f52e34a350268',
  //   'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1114%2F052021113427%2F210520113427-8-1200.jpg&refer=http%3A%2F%2Fimg.jj20'
  //       '.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654761426&t=a1771d04b7a143e15bf159ee30083fce',
  //   'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202107%2F28%2F20210728092731_1a7ea.thumb.1000_0.jpeg&refer=http%3A%2F%2Fc-ssl'
  //       '.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1654761426&t=7715e5c12087f6255c5a85839184d073',
  // ];

  List<String> imageTemp = [
    Assets.imagesTemp1,
    Assets.imagesTemp2,
    Assets.imagesTemp3,
    Assets.imagesTemp4,
    Assets.imagesTemp5,
    Assets.imagesTemp6,
    Assets.imagesTemp7,
    Assets.imagesTemp8,
  ];
}

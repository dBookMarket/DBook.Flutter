import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dbook/business/issues/secondary_market/secondary_market_view.dart';
import 'package:dbook/common/config/app_config.dart';
import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/utils/loading.dart';
import 'package:dbook/common/utils/logger.dart';
import 'package:dbook/common/utils/string_helper.dart';
import 'package:dbook/common/values/values.dart';
import 'package:dbook/common/widgets/appBar.dart';
import 'package:dbook/common/widgets/button.dart';
import 'package:dbook/common/widgets/dialog.dart';
import 'package:dbook/common/widgets/line_widget.dart';
import 'package:dbook/common/widgets/text.dart';
import 'package:dbook/common/widgets/view_state/base_container_view.dart';
import 'package:dbook/common/widgets/web_page/web_page_view.dart';
import 'package:dbook/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common/services/global_time.dart';
import '../../../common/store/web3.dart';
import '../../../common/utils/date.dart';
import '../../asset_detail/asset_detail_view.dart';
import '../../assets/assets_state.dart';
import '../../assets/assets_view.dart';
import '../../login/import_memories/import_memories_view.dart';
import '../../mine/profile_settings/twitterShare/twitter_share_view.dart';
import '../issues_state.dart';
import 'issues_detail_logic.dart';

class IssuesDetailPage extends StatelessWidget {
  final logic = Get.put(IssuesDetailLogic());
  final state = Get.find<IssuesDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Book details', actions: _action()),
      body: _body(),
    );
  }

  List<Widget> _action() => [_share(), _wish()];

  Widget _share() => GestureDetector(
        onTap: () => _onClick('share'),
        child: Container(
          padding: EdgeInsets.only(right: ScreenConfig.marginH / 2),
          child: SvgPicture.asset(
            Assets.svgShare,
            width: 50.r,
          ),
        ),
      );

  Widget _wish() {
    return GestureDetector(
      onTap: () => _onClick('wish'),
      child: Container(
        padding: EdgeInsets.only(right: ScreenConfig.marginH),
        child: Obx(() {
          return SvgPicture.asset(
            (state.issuesInfo.value.isWished ?? false) ? Assets.svgCollectSelected : Assets.svgCollectUnselect,
            width: 50.r,
          );
        }),
      ),
    );
  }

  Widget _body() => BaseContainer(
      viewState: state.viewState,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: ScreenConfig.marginH, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              state.issuesInfo.value.book?.coverUrl ?? '',
              width: 1.sw,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 30.h),
            TextX(state.issuesInfo.value.book?.title, textAlign: TextAlign.start, fontSize: FontSizeX.s16, color: ColorX.txtTitle, fontWeight: TextX.bold),
            SizedBox(height: 20.h),
            _author(),
            SizedBox(height: 20.h),
            TextX(state.issuesInfo.value.book?.desc, textAlign: TextAlign.start, fontSize: FontSizeX.s11, color: ColorX.txtHint, maxLines: 100),
            SizedBox(height: 20.h),
            _trialButton(),
            _publication(),
            _destroyed(),
            SecondaryMarketPage()
          ],
        ),
      ));

  Widget _contactItem({required String img, String? url}) {
    if (url == null || url.isEmpty) return SizedBox();
    return Container(
      margin: EdgeInsets.only(right: 22.w),
      color: Colors.white,
      child: GestureDetector(
          child: SvgPicture.asset(
            img,
            width: 40.w,
            colorBlendMode: BlendMode.clear,
          ),
          onTap: () {
            if (url == null || url.isEmpty) {
              state.setError(t: 'no yet');
              return;
            }
            Get.to(() => WebPageView('', url));
          }),
    );
  }

  Widget _author() => Row(children: [
        InkWell(
          onTap: () => _onClick('author'),
          child: Row(
            children: [
              TextX(state.issuesInfo.value.book?.author?.name, textAlign: TextAlign.start, fontSize: FontSizeX.s11, color: ColorX.txtTitle, fontWeight: TextX.bold, maxLines: 100),
              TextX('(${formatAddress(state.issuesInfo.value.book?.author?.address)})', textAlign: TextAlign.start, fontSize: FontSizeX.s11, color: ColorX.txtHint, maxLines: 100)
            ],
          ),
        ),
        Expanded(child: SizedBox()),
        _contactItem(img: Assets.svgLogoWeb, url: state.issuesInfo.value.book?.author?.websiteUrl),
        _contactItem(img: Assets.svgLogoDiscord, url: state.issuesInfo.value.book?.author?.discordUrl),
        _contactItem(img: Assets.svgLogoTwitter, url: state.issuesInfo.value.book?.author?.twitterUrl),
      ]);

  Widget _trialButton() => ButtonX(
        'Trial reading',
        backgroundColor: Color(0xFF50483B),
        borderRadius: 0,
        textColor: Color(0xFFFFE1B4),
        fontSize: FontSizeX.s13,
        padding: EdgeInsets.symmetric(vertical: 24.h),
        onPressed: () => _onClick('试读', param: state.issuesInfo.value),
      );

  //region 出版信息
  Widget _publication() => _boxContainer(
          child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10.r,
                        height: 10.r,
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100)),
                      ),
                      SizedBox(width: 20.w),
                      TextX('Publication', fontSize: FontSizeX.s16, color: Color(0xFF42392B), fontWeight: TextX.bold)
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _comingDay(state.issuesInfo.value.publishedAt)
                ],
              ),
              Expanded(child: SizedBox()),
              _publicationTime(),
            ],
          ),
          LineH(margin: EdgeInsets.only(top: 30.h, bottom: 20.h)),
          _publicChain(),
          LineH(margin: EdgeInsets.only(top: 30.h, bottom: 20.h)),
          _publicCount(),
          SizedBox(height: 20.h),
          Obx(() {
            return _tradeButton();
          }),
        ],
      ));

  Widget _comingDay(time) {
    return Row(children: [
      SvgPicture.asset(Assets.svgComingTime, width: 20.w, color: ColorX.txtBrown),
      SizedBox(width: 11.w),
      Container(
        child: TextX(bookPublicationTimeFormat(DateUtil.getDateTime(time)), fontSize: FontSizeX.s11, color: ColorX.txtBrown),
        decoration: BoxDecoration(color: ColorX.primaryYellow, borderRadius: BorderRadius.circular(100)),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
      )
    ]);
  }

  Widget _publicationTime() => Obx(() {
        GlobalTimeService.to.globalTime.value;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _publicationTimeItem(value: logic.comingTime().inDays - 1, key: 'DAYS'),
            Container(child: TextX(':', fontSize: FontSizeX.s13), padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w)),
            _publicationTimeItem(value: logic.comingTime().inHours % 24, key: 'HOURS'),
            Container(child: TextX(':', fontSize: FontSizeX.s13), padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w)),
            _publicationTimeItem(value: logic.comingTime().inMinutes % 60, key: 'MINUTES'),
            Container(child: TextX(':', fontSize: FontSizeX.s13), padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w)),
            _publicationTimeItem(value: logic.comingTime().inSeconds % 60, key: 'SECONDS'),
          ],
        );
      });

  Widget _publicationTimeItem({required String key, required int value}) {
    String valueStr = logic.countDownAdd0(value);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorX.primaryBlack,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.all(12.r),
          child: TextX(valueStr, color: ColorX.txtWhite, fontSize: FontSizeX.s13),
        ),
        SizedBox(height: 10.h),
        TextX(key, fontSize: FontSizeX.s7),
      ],
    );
  }

  Widget _publicChain() => Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextX('Public chain', fontSize: FontSizeX.s13, color: ColorX.txtHint),
            TextX(state.issuesInfo.value.token?.blockChain, fontSize: FontSizeX.s13, color: ColorX.txtHint),
            // TextX(DateUtil.formatDateMs(GlobalTimeService.to.globalTime.value), fontSize: FontSizeX.s13, color: ColorX.txtHint),
          ],
        );
      });

  Widget _publicCount() => Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _publicCountItem(
              t1: 'Supply',
              v1: state.issuesInfo.value.quantity.toString(),
              t2: 'Available',
              v2: ((state.issuesInfo.value.quantity ?? 0) - (state.issuesInfo.value.nCirculations ?? 0)).toString(),
            ),
            _publicCountItem(
              t1: 'Selling Price',
              v1: '${removeZero(state.issuesInfo.value.price.toString())} USDC',
              t2: 'Limited per person',
              v2: state.issuesInfo.value.buyLimit.toString(),
            ),
            _publicCountItem(
              t1: 'Supply cycle',
              v1: '${(state.issuesInfo.value.duration ?? 0).toString()} minutes',
              t2: 'You have',
              v2: state.issuesInfo.value.nOwned.toString(),
            ),
          ],
        );
      });

  Widget _publicCountItem({required String t1, required String t2, required String v1, required String v2}) => Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextX(t1, fontSize: FontSizeX.s11, color: ColorX.txtHint),
              SizedBox(height: 10.h),
              TextX(v1, fontSize: FontSizeX.s13, color: ColorX.txtTitle),
              SizedBox(height: 14.h),
              TextX(t2, fontSize: FontSizeX.s11, color: ColorX.txtBrown),
              TextX(v2, fontSize: FontSizeX.s11, color: ColorX.txtBrown),
            ],
          )
        ],
      );

  Widget _tradeButton() {
    var buttonValid = state.issuesInfo.value.book?.author?.id != UserStore.to.userInfo.id;

    if (state.issuesInfo.value.status == IssuesStatus.pre_sale.name) {
      return ButtonX(
        'Add a calendar',
        borderRadius: 0,
        backgroundColor: Color(0xFF50483B),
        textColor: ColorX.txtYellow,
        padding: EdgeInsets.symmetric(vertical: 24.h),
        onPressed: () => _onClick('添加到日历'),
      );
    } else if (state.issuesInfo.value.status == IssuesStatus.on_sale.name) {
      return ButtonX(
        'Buy',
        borderRadius: 0,
        backgroundColor: buttonValid ? Color(0xFF50483B) : ColorX.buttonInValid,
        textColor: buttonValid ? ColorX.txtYellow : ColorX.txtWhite,
        enable: buttonValid,
        padding: EdgeInsets.symmetric(vertical: 24.h),
        onPressed: () => _onClick('购买'),
      );
    } else {
      return ButtonX(
        'Sellout',
        borderRadius: 0,
        backgroundColor: ColorX.buttonInValid,
        textColor: ColorX.txtWhite,
        padding: EdgeInsets.symmetric(vertical: 24.h),
        // onPressed: () => _onClick(''),
      );
    }
  }

  //endregion

  Widget _destroyed() {
    return Obx(() {
      var count = 0;
      var address = '~';
      var stateStr = '00:00:00';
      bool isRed = false;
      bool clickAble = false;
      GlobalTimeService.to.globalTime.value;
      if (state.issuesInfo.value.status == IssuesStatus.pre_sale.name) {
        count = 0;
        address = '~~';
        stateStr = 'Not started';
        isRed = true;
      } else if (state.issuesInfo.value.status == IssuesStatus.on_sale.name) {
        var d = '${logic.comingTime().inDays - 1 <= 0 ? '' : '${logic.countDownAdd0(logic.comingTime().inDays - 1)}:'}';
        var h = logic.countDownAdd0(logic.comingTime().inHours % 24);
        var m = logic.countDownAdd0(logic.comingTime().inMinutes % 60);
        var s = logic.countDownAdd0(logic.comingTime().inSeconds % 60);
        var duration = '$d$h:$m:$s';

        if ((state.issuesInfo.value.nCirculations ?? 0) == 0) duration = 'Not started';

        count = 0;
        address = '~~~';
        stateStr = duration;
        isRed = false;
      } else if (state.issuesInfo.value.status == IssuesStatus.off_sale.name) {
        count = (state.issuesInfo.value.quantity ?? 0) - (state.issuesInfo.value.nCirculations ?? 0);
        address = formatAddress(state.issuesInfo.value.destroyLog);
        if (address.length != 0) {
          clickAble = true;
        }
        stateStr = 'destroyed';
        isRed = false;
      } else {
        count = (state.issuesInfo.value.quantity ?? 0) - (state.issuesInfo.value.nCirculations ?? 0);
        address = '~~';
        stateStr = 'unsold';
        isRed = true;
      }
      return _boxContainer(
          title: 'Destroyed',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_destroyedItem('Quantity destroyed', '$count'), _destroyedItem('Execution logging', '$address', clickAble: clickAble), _destroyedItem('State', '$stateStr', isValueRed: isRed)],
          ));
    });
  }

  Widget _destroyedItem(String title, String value, {bool? isValueRed = false, bool clickAble = false}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextX(title, fontSize: FontSizeX.s11, color: ColorX.txtHint),
          SizedBox(height: 10.h),
          InkWell(
            onTap: () => _onClick('hash'),
            child: TextX(
              value,
              fontSize: FontSizeX.s13,
              color: isValueRed! ? ColorX.txtRed : ColorX.txtTitle,
              style: clickAble
                  ? TextStyle(fontSize: FontSizeX.s13, color: ColorX.txtBrown, decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.solid, decorationColor: ColorX.txtBrown)
                  : null,
            ),
          ),
        ],
      );

  Widget _boxContainer({required Widget child, String? title, EdgeInsets? padding}) => Container(
        margin: EdgeInsets.only(top: 30.h),
        padding: padding ?? EdgeInsets.all(26.r),
        decoration: BoxDecoration(
          border: Border.all(width: 1.r, color: Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title == null
                ? SizedBox()
                : Row(
                    children: [
                      Container(
                        width: 10.r,
                        height: 10.r,
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100)),
                      ),
                      SizedBox(width: 20.w),
                      TextX(title, fontSize: FontSizeX.s16, color: Color(0xFF42392B), fontWeight: TextX.bold)
                    ],
                  ),
            SizedBox(height: title == null ? 0 : 12.h),
            child
          ],
        ),
      );

  Widget _buyDialog() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextX('price     ', textAlign: TextAlign.start),
            SizedBox(width: 40.w),
            TextX(state.issuesInfo.value.price.toString() + 'USDC'),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextX('quantity'),
            SizedBox(width: 40.w),
            InkWell(child: Container(child: Icon(Icons.chevron_left), color: Color(0xFFFFF7E9), margin: EdgeInsets.only(right: 20.w)), onTap: () => logic.amountSub()),
            Obx(() {
              return TextX(state.buyAmount.value.toString());
            }),
            InkWell(child: Container(child: Icon(Icons.chevron_right), color: Color(0xFFFFF7E9), margin: EdgeInsets.only(left: 20.w)), onTap: () => logic.amountAdd()),
          ],
        ),
      ],
    );
  }

  _onClick(String type, {param}) async {
    logX.d('点击了>>>>$type  $param');
    switch (type) {
      case '试读':
        Get.to(() => AssetDetailPage(), arguments: {'downloadUrl': state.issuesInfo.value.book?.preview?.url});
        break;

      case '添加到日历':
        if (state.issuesInfo.value.publishedAt == null || state.issuesInfo.value.publishedAt!.isEmpty) return;
        var time = DateUtil.getDateTime(state.issuesInfo.value.publishedAt!)?.add(DateTime.now().timeZoneOffset);
        if (time == null) return;

        final Event event = Event(
          title: state.issuesInfo.value.book?.title ?? 'New Book',
          description: '${state.issuesInfo.value.book?.title ?? 'New Book'} publish notification',
          location: '',
          startDate: time,
          endDate: time.add(Duration(days: 1)),
          iosParams: IOSParams(
            reminder: Duration(hours: 2), // on iOS, you can set alarm notification after your event.
            url: 'https://dbookmarket.com', // on iOS, you can set url to your event.
          ),
          androidParams: AndroidParams(
            emailInvites: [], // on Android, you can add invite emails to your event.
          ),
        );
        Add2Calendar.addEvent2Cal(event);
        break;
      case '购买':
        if (!UserStore.to.isLogin) {
          Get.to(() => ImportMemoriesPage());
          return;
        }
        var limit = (state.issuesInfo.value.buyLimit ?? 1) - (state.issuesInfo.value.nOwned ?? 0);
        if (limit == 0) {
          showInfo(t: 'You have reached the purchase limit');
          return;
        }
        Get.dialog(DialogX(
          title: 'Buy',
          contentWidget: _buyDialog(),
          left: 'Cancel',
          right: 'Buy',
          rightCallback: () => logic.buy(),
        ));
        break;
      case 'author':
        Get.to(() => AssetsPage(), arguments: {'title': 'Author Detail', 'assetsType': AssetsType.AUTHOR, 'userId': state.issuesInfo.value.book?.author?.id.toString()}, preventDuplicates: false);
        break;
      case 'wish':
        logic.wish();
        break;
      case 'hash':
        var token = state.issuesInfo.value.token;
        var hash = state.issuesInfo.value.destroyLog ?? '';
        if (token?.blockChain == PublicChainType.bnb.name) {
          Get.to(() => WebPageView('Transaction', ScanConfig.bnb + hash));
        } else if (token?.blockChain == PublicChainType.polygon.name) {
          Get.to(() => WebPageView('Transaction', ScanConfig.polygon + hash));
        } else if (token?.blockChain == PublicChainType.filecoin.name) {
          Get.to(() => WebPageView('Message', ScanConfig.fileCoin + hash));
        }
        break;
      case 'share':
        Get.to(() => TwitterShareView(
              authorName: state.issuesInfo.value.book?.author?.name ?? '',
              bookId: state.issuesInfo.value.id.toString(),
              bookName: state.issuesInfo.value.book?.title ?? '',
            ));
        break;
    }
  }
}

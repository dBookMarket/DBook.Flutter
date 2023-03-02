import 'package:dbook/business/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:dbook/common/langs/translation_service.dart';
import 'package:dbook/common/routes/pages.dart';
import 'package:dbook/common/store/store.dart';
import 'package:dbook/common/style/style.dart';
import 'package:dbook/global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'common/config/app_config.dart';

Future<void> main() async {
  await Global.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(ScreenConfig.designW, ScreenConfig.designH),
      builder: (c,w) => RefreshConfiguration(
        headerBuilder: () => ClassicHeader(),
        footerBuilder: () => ClassicFooter(),
        hideFooterWhenNotFull: true,
        headerTriggerDistance: 80,
        maxOverScrollExtent: 100,
        footerTriggerDistance: 150,
        child: GetMaterialApp(
          title: 'dbook',
          theme: AppTheme.light,
          debugShowCheckedModeBanner: false,
          // initialRoute: AppPages.INITIAL,
          // getPages: AppPages.routes,
          home: SplashPage(),
          builder: EasyLoading.init(),
          translations: TranslationService(),
          navigatorObservers: [AppPages.observer],
          getPages: AppPages.routes,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: ConfigStore.to.languages,
          locale: ConfigStore.to.locale,

          fallbackLocale: Locale('en', 'US'),
          enableLog: true,
          logWriterCallback: defaultLogWriterCallback,
        ),
      ),
    );
  }
}

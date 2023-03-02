import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../business/assets/assets_view.dart';
import '../../business/login/guide/view.dart';
import '../../business/login/import_memories/import_memories_view.dart';
import '../../business/login/setting_password/setting_password_view.dart';
import '../../business/main/view.dart';
import '../../business/mine/concern/concern_view.dart';
import '../../business/mine/create_book/create_book_view.dart';
import '../../business/mine/profile_settings/profile_settings_view.dart';
import '../../business/mine/profile_settings/twitterAuth/twitter_auth_view.dart';
import '../../business/mine/wallet/wallet_view.dart';
import '../../business/mine/writing/view.dart';
import '../middlewares/router_auth.dart';
import '../middlewares/router_twitter_auth.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.MAIN,
      page: () => MainPage(),
    ),
    GetPage(
      name: AppRoutes.Guide,
      page: () => GuidePage(),
    ),
    GetPage(
      name: AppRoutes.TwitterAuth,
      page: () => TwitterAuthView(),
    ),
    GetPage(
      name: AppRoutes.ImportMemories,
      page: () => ImportMemoriesPage(),
    ),
    GetPage(
      name: AppRoutes.SettingPassword,
      page: () => SettingPasswordPage(),
    ),
    GetPage(
      name: AppRoutes.CreateBook,
      page: () => CreateBookPage(),
      middlewares: [RouteAuthMiddleware(),RouteTwitterAuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.Assets,
      page: () => AssetsPage(),
      middlewares: [RouteAuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.Wallet,
      page: () => WalletPage(),
      middlewares: [RouteAuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.Concern,
      page: () => ConcernPage(),
      middlewares: [RouteAuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.Writing,
      page: () => WritingPage(),
      middlewares: [RouteAuthMiddleware(),RouteTwitterAuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.ProfileSettings,
      page: () => ProfileSettingsPage(),
      middlewares: [RouteAuthMiddleware()],
    ),
  ];

// static final unknownRoute = GetPage(
//   name: AppRoutes.NotFound,
//   page: () => NotfoundView(),
// );

}

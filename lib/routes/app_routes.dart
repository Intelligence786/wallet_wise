import 'package:flutter/material.dart';
import 'package:wallet_wise/presentation/add_wallet_change_screen/add_wallet_change_screen.dart';
import 'package:wallet_wise/presentation/news_content_screen/news_content_screen.dart';
import 'package:wallet_wise/presentation/onboarding_screen/onboarding_screen.dart';

import '../data/models/news_model/news_model.dart';
import '../presentation/navigation_bar_screen/navigation_bar_screen.dart';

class AppRoutes {
  static const String navigationBarScreen = '/navigation_bar_screen';

  static const String onboardingScreen = '/onboarding_screen';

  static const String addWalletChangeScreen = '/add_wallet_change_screen';

  static const String financePage = '/finance_page';

  static const String settingsPage = '/settings_page';

  static const String newsPage = '/news_page';

  static const String statisticsPage = '/statistics_page';

  static const String matchInfoScreen = '/match_info_screen';

  static const String newsScreen = '/news_screen';

  static Map<String, WidgetBuilder> get routes => {
        navigationBarScreen: NavigationBarScreen.builder,
        onboardingScreen: OnboardingScreen.builder,
        addWalletChangeScreen: (context) {
          final arguments = ModalRoute.of(context)!.settings.arguments as bool;
          return AddWalletChangeScreen.builder(context, arguments);
        },
        newsScreen: (context) {
          final arguments =
              ModalRoute.of(context)!.settings.arguments as NewsModel;
          return NewsContentScreen.builder(context, arguments);
        },

      };
}

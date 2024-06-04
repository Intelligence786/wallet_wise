import 'package:flutter/material.dart';
import 'package:wallet_wise/presentation/finance_page/finance_page.dart';
import 'package:wallet_wise/presentation/news_page/news_page.dart';
import 'package:wallet_wise/presentation/settings_page/settings_page.dart';
import 'package:wallet_wise/presentation/statistics_page/statistics_page.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';

class NavigationBarScreen extends StatelessWidget {
  NavigationBarScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return NavigationBarScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: theme.colorScheme.onPrimary,
      body: Stack(
        children: [
          Navigator(
            key: navigatorKey,
            initialRoute: AppRoutes.financePage,
            onGenerateRoute: (routeSetting) => PageRouteBuilder(
              pageBuilder: (ctx, ani, ani1) =>
                  getCurrentPage(context, routeSetting.name!),
              transitionDuration: Duration(seconds: 0),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildBottomBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Finance:
        return AppRoutes.financePage;
      case BottomBarEnum.Statistics:
        return AppRoutes.statisticsPage;
      case BottomBarEnum.News:
        return AppRoutes.newsPage;
      case BottomBarEnum.Settings:
        return AppRoutes.settingsPage;
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(BuildContext context, String currentRoute) {
    print(currentRoute);
    switch (currentRoute) {
      case AppRoutes.financePage:
        return FinancePage();
      case AppRoutes.statisticsPage:
        return StatisticsPage();
      case AppRoutes.newsPage:
        return NewsPage();
      case AppRoutes.settingsPage:
        return SettingsPage();
      default:
        return DefaultWidget();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_wise/core/app_export.dart';

import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Widget builder(BuildContext context) {
    return SettingsPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppbarTitle(
          text: '',
        ),
        height: 1,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.only(bottom: 5.v),
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Settings',
              style: theme.textTheme.headlineLarge,
            ),
            SizedBox(height: 8.v),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: AppDecoration.fillSecondaryContainer,
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        prefs.clear();

                        NavigatorService.pushNamedAndRemoveUntil(
                            AppRoutes.onboardingScreen);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgRestart,
                            ),
                            SizedBox(width: 16.h),
                            Text(
                              'Reset Balance',
                              style: CustomTextStyles
                                  .titleMediumSecondaryContainer,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.v, bottom: 16.v),
                  child: Text(
                    'Resetting the entire current balance.',
                    style: CustomTextStyles.titleMediumRoboto,
                  ),
                ),
                _buildSettingsButton(
                  context,
                  imagePath: ImageConstant.imgTerms,
                  name: 'Terms of use',
                  onTap: () {},
                ),
                SizedBox(height: 8.v),
                _buildSettingsButton(
                  context,
                  imagePath: ImageConstant.imgPrivacy,
                  name: 'Privacy Policy',
                  onTap: () {},
                ),
                SizedBox(height: 8.v),
                _buildSettingsButton(
                  context,
                  imagePath: ImageConstant.imgSupport,
                  name: 'Support page',
                  onTap: () {},
                ),
                SizedBox(height: 8.v),
                _buildSettingsButton(
                  context,
                  imagePath: ImageConstant.imgShare,
                  name: 'Share with friends',
                  onTap: () {},
                ),
                SizedBox(height: 8.v),
                _buildSettingsButton(
                  context,
                  imagePath: ImageConstant.imgSubscription,
                  name: 'Subscription info',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: 80.v,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsButton(BuildContext context,
      {String imagePath = '', String name = '', Function? onTap}) {
    return Container(
      decoration: AppDecoration.fillSecondaryContainer,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadiusStyle.roundedBorder8,
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: AppDecoration.fillSecondaryContainer,
                  padding: EdgeInsets.all(8.h),
                  child: CustomImageView(
                    imagePath: imagePath,
                  ),
                ),
                SizedBox(width: 8.h),
                Expanded(
                  child: Text(
                    name,
                    style: CustomTextStyles.titleMediumSecondaryContainer,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: theme.colorScheme.primary,
                  size: 20.adaptSize,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

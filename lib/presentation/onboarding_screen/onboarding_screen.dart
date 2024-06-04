import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return OnboardingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        //  width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgOnboarding,
              height: 310.v,
              width: 358.h,
            ),
            Container(
              width: 251.h,
              margin: EdgeInsets.symmetric(
                horizontal: 53.h,
              ),
              child: Text(
                'Simplify the\nmanagement of\nyour money.',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge!.copyWith(
                  height: 1.25,
                ),
              ),
            ),
            SizedBox(height: 4.v),
            Container(
              //width: 307.h,
              margin: EdgeInsets.symmetric(horizontal: 16.h),
              child: Text(
                'Your personal financial assistant in your\npocket: plan your budget, track your\nfinances using our app.',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium!.copyWith(
                  height: 1.38,
                ),
              ),
            ),
            SizedBox(height: 62.v),
            CustomElevatedButton(
                height: 48.v,
                text: 'Get started',
                buttonStyle: CustomButtonStyles.fillPrimary,
                onPressed: () {
                  NavigatorService.pushNamedAndRemoveUntil(AppRoutes.navigationBarScreen);
                }),
            SizedBox(height: 25.v),
            Text(
              'Terms of Use / Privacy Policy',
              style: theme.textTheme.bodyMedium,
            ),
            // SizedBox(height: 8.v)
          ],
        ),
      ),
    );
  }
}

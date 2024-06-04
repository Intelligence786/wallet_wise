import 'package:flutter/material.dart';
import 'package:wallet_wise/core/app_export.dart';

import '../../../data/data_manager.dart';
import '../../../widgets/number_loading_animation.dart';
import '../finance_page.dart';

class AddTransactionBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h).copyWith(top: 8.v),
      height: 300.v,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: AppDecoration.fillOnPrimary.copyWith(
                color: appTheme.black900.withOpacity(0.5),
                borderRadius: BorderRadiusStyle.roundedBorder16),
            height: 5.v,
            width: 40.h,
          ),
          SizedBox(height: 4.v),
          Text(
            'What do you want to add?',
            style: CustomTextStyles.titleMediumSecondaryContainerBold,
          ),
          SizedBox(height: 16.v),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: AppDecoration.fillSecondaryContainer,
                padding: EdgeInsets.all(4.h),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.h),
                      decoration: AppDecoration.fillSecondaryContainer,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgIncome,
                      ),
                    ),
                    SizedBox(width: 8.v),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Income',
                            style: CustomTextStyles.titleSmallSemiBold,
                          ),
                          FutureBuilder<double>(
                            future: DataManager.getTotalIncomes(),
                            // The method that fetches the total income
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return NumberLoadingAnimation(); // Показать анимацию загрузки
                              } else if (snapshot.hasError) {
                                return Text(
                                    'Error'); // Handle errors appropriately
                              } else {
                                return AnimatedNumberDisplay(
                                    endValue: snapshot.data ??
                                        0.0); // Отобразить анимацию чисел
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: AppDecoration.fillPrimary,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 4.v),
                        child: InkWell(
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgPlus,
                                color: Colors.white,
                              ),
                              Text(
                                'Add Income',
                                style: CustomTextStyles.titleMediumOnPrimary,
                              ),
                            ],
                          ),
                          onTap: () {
                            NavigatorService.pushNamed(
                                AppRoutes.addWalletChangeScreen,
                                arguments: true);
                            // Implement the logic to add income
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.v),
              Container(
                decoration: AppDecoration.fillSecondaryContainer,
                padding: EdgeInsets.all(4.h),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.h),
                      decoration: AppDecoration.fillSecondaryContainer,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgExpense,
                      ),
                    ),
                    SizedBox(width: 8.v),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Expense',
                            style: CustomTextStyles.titleSmallSemiBold,
                          ),
                          FutureBuilder<double>(
                            future: DataManager.getTotalExpenses(),
                            // The method that fetches the total income
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return NumberLoadingAnimation(); // Показать анимацию загрузки
                              } else if (snapshot.hasError) {
                                return Text(
                                    'Error'); // Handle errors appropriately
                              } else {
                                return AnimatedNumberDisplay(
                                    endValue: snapshot.data ??
                                        0.0); // Отобразить анимацию чисел
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: AppDecoration.fillPrimary,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.h, vertical: 4.v),
                        child: InkWell(
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgPlus,
                                color: Colors.white,
                              ),
                              Text(
                                'Add Expense',
                                style: CustomTextStyles.titleMediumOnPrimary,
                              ),
                            ],
                          ),
                          onTap: () {
                            NavigatorService.pushNamed(
                                AppRoutes.addWalletChangeScreen,
                                arguments: false);
                            // Implement the logic to add income
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

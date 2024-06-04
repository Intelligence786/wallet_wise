import 'package:flutter/material.dart';
import 'package:wallet_wise/data/data_manager.dart';
import 'package:wallet_wise/data/models/wallet_model/wallet_model.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/number_loading_animation.dart';

class TypeCategoryWiget extends StatelessWidget {
  TypeCategoryWiget({
    Key? key,
    this.incomeType = IncomeType.none,
    this.expenseType = ExpenseType.none,
    this.isIncome = true,
  }) : super(
          key: key,
        );
  IncomeType incomeType;
  ExpenseType expenseType;
  bool isIncome;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.h),
      decoration: AppDecoration.fillSecondaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconButton(
            height: 40.adaptSize,
            width: 40.adaptSize,
            padding: EdgeInsets.all(8.h),
            child: CustomImageView(
              imagePath: isIncome
                  ? WalletChangeDataParser.getIncomeImageUrl(incomeType)
                  : WalletChangeDataParser.getExpenseImageUrl(expenseType),
            ),
          ),
          SizedBox(height: 17.v),
          Text(
            isIncome
                ? WalletChangeDataParser.getIncomeTitle(incomeType)
                : WalletChangeDataParser.getExpenseTitle(expenseType),
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 4.v),
          isIncome
              ? FutureBuilder<double>(
                  future: DataManager.getTotalIncomesByType(incomeType),
                  // The method that fetches the total income
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return NumberLoadingAnimation(); // Показать анимацию загрузки
                    } else if (snapshot.hasError) {
                      return Text('Error'); // Handle errors appropriately
                    } else {
                      return AnimatedNumberDisplay(
                          endValue: snapshot.data ??
                              0.0); // Отобразить анимацию чисел
                    }
                  },
                )
              : FutureBuilder<double>(
                  future: DataManager.getTotalExpensesByType(expenseType),
                  // The method that fetches the total income
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return NumberLoadingAnimation(); // Показать анимацию загрузки
                    } else if (snapshot.hasError) {
                      return Text('Error'); // Handle errors appropriately
                    } else {
                      return AnimatedNumberDisplay(
                          endValue: snapshot.data ??
                              0.0); // Отобразить анимацию чисел
                    }
                  },
                ),
        ],
      ),
    );
  }
}

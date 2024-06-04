import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:wallet_wise/core/app_export.dart';
import 'package:wallet_wise/data/data_manager.dart';
import 'package:wallet_wise/widgets/custom_icon_button.dart';

import '../../data/models/wallet_model/wallet_model.dart';
import '../../widgets/number_loading_animation.dart';
import 'widgets/add_transaction_bottom_sheet.dart';
import 'widgets/wallet_change_main_widget.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  static Widget builder(BuildContext context) {
    return FinancePage();
  }

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  @override
  void initState() {
    DataManager.getWallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 100.v,
            ),
            _buildBalanceWidget(context),
            SizedBox(
              height: 10.v,
            ),
            Expanded(
              child: _buildFinanceTab(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Balance',
          style: CustomTextStyles.titleSmallSemiBold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder<double>(
              future: DataManager.getTotalBalance(),
              // The method that fetches the total income
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return NumberLoadingAnimation(
                    textStyle: theme.textTheme.displayMedium,
                  ); // Показать анимацию загрузки
                } else if (snapshot.hasError) {
                  return Text('Error'); // Handle errors appropriately
                } else {
                  return AnimatedNumberDisplay(
                    endValue: snapshot.data ?? 0.0,
                    textStyle: theme.textTheme.displayMedium,
                  ); // Отобразить анимацию чисел
                }
              },
            ),

            CustomIconButton(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return AddTransactionBottomSheet();
                  },
                );
              },
              height: 50.h,
              width: 50.h,
              decoration: IconButtonStyleHelper.fillPrimary,
              padding: EdgeInsets.all(8.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgPlus,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.v),
                decoration: AppDecoration.fillSecondaryContainer,
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgIncome,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    Text(
                      'Income',
                      style: CustomTextStyles.titleMediumRoboto,
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    FutureBuilder<double>(
                      future: DataManager.getTotalIncomes(),
                      // The method that fetches the total income
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
              ),
              SizedBox(
                width: 10.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.v),
                decoration: AppDecoration.fillSecondaryContainer,
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgIncome,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    Text(
                      'Expense',
                      style: CustomTextStyles.titleMediumRoboto,
                    ),
                    SizedBox(
                      width: 10.h,
                    ),
                    FutureBuilder<double>(
                      future: DataManager.getTotalExpenses(),
                      // The method that fetches the total income
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFinanceTab(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            //decoration: AppDecoration.fillPrimary,
            // constraints: BoxConstraints(maxHeight: 150.0),
            child: ButtonsTabBar(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.h),
              buttonMargin:
                  EdgeInsets.symmetric(vertical: 4.v).copyWith(right: 20.h),
              center: false,
              decoration: AppDecoration.fillPrimary,
              unselectedDecoration: AppDecoration.fillSecondaryContainer,
              unselectedLabelStyle: CustomTextStyles.titleMediumRoboto,
              labelStyle: CustomTextStyles.titleMediumRobotoOnPrimary,
              height: 40.h,
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Income'),
                Tab(text: 'Expense'),
              ],
            ),
          ),
          SizedBox(
            height: 8.v,
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildListOfData(context,
                    list: DataManager.getAllTransactionsSortedByDate()),
                _buildListOfData(context, list: DataManager.getIncomeList()),
                _buildListOfData(context, list: DataManager.getExpenseList()),
              ],
            ),
          ),
          SizedBox(
            height: 90.v,
          ),
        ],
      ),
    );
  }

  Widget _buildListOfData(
    BuildContext context, {
    required Future<List<WalletChangeData>> list,
  }) {
    return FutureBuilder<List<WalletChangeData>>(
      future: list,
      // The method that fetches the total income
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          ); // Показать анимацию загрузки
        } else if (snapshot.hasError) {
          return Text('Error'); // Handle errors appropriately
        } else if (snapshot.data!.isEmpty) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(6.h),
                decoration: AppDecoration.fillSecondaryContainer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: AppDecoration.fillPrimary.copyWith(
                          color: theme.colorScheme.primary.withOpacity(0.14),
                          borderRadius: BorderRadiusStyle.roundedBorder8),
                      padding: EdgeInsets.all(8.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgAlert,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      'Your balance is empty',
                      style: CustomTextStyles
                          .titleMediumRobotoSecondaryContainer_1,
                    ),
                    Text(
                      'Add Expenses or Income so you can track your financial spending.',
                      style: CustomTextStyles.titleSmallSemiBold,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data?.length,
            padding: EdgeInsets.zero,
            // Change this to the number of items you want
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.v),
                child: WalletChangeMainWidget(
                    walletChangeData: snapshot.data![index]),
              );
            },
          ); // Отобразить анимацию чисел
        }
      },
    );
  }
}

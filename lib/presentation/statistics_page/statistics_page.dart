import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:wallet_wise/presentation/statistics_page/widget/type_category_wiget.dart';
import 'package:wallet_wise/widgets/app_bar/appbar_title.dart';
import 'package:wallet_wise/widgets/app_bar/custom_app_bar.dart';

import '../../core/app_export.dart';
import '../../data/data_manager.dart';
import '../../data/models/wallet_model/wallet_model.dart';
import '../../widgets/number_loading_animation.dart';
import 'widget/statistics_charts.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  static Widget builder(BuildContext context) {
    return StatisticsPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(title: AppbarTitle(text: '',), height: 1,),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5.v),
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Statistics',
                  style: theme.textTheme.headlineLarge,
                ),
                SizedBox(height: 8.v),
                _buildStats(context),
                SizedBox(height: 8.v),
                _buildBalance(context),
                SizedBox(height: 8.v),
                _buildCategories(context),
                /*  _buildPrice(context),
                SizedBox(height: 8.v),
                _buildRowamount(context),
                SizedBox(height: 16.v),
                Row(
                  children: [
                    _buildIncome(context),
                    _buildExpense(context)
                  ],
                ),
                SizedBox(height: 8.v),
                _buildCategory(context)*/
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.h),
            decoration: AppDecoration.fillSecondaryContainer,
            height: 200.v,
            child: TabBarView(
              children: [
                _buildListOfData(
                  context,
                  period: 'day',
                ),
                _buildListOfData(
                  context,
                  period: 'week',
                ),
                _buildListOfData(
                  context,
                  period: 'month',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.v,
          ),
          Container(
            //decoration: AppDecoration.fillPrimary,
            //constraints: BoxConstraints(maxHeight: 150.0),
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
                Tab(text: 'Today'),
                Tab(text: 'Week'),
                Tab(text: 'Month'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListOfData(
    BuildContext context, {
    required String period,
  }) {
    return StatisticsChart(
      period: period,
      fetchBalanceData: DataManager.getDailyBalance,
    );
  }

  Widget _buildBalance(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: AppDecoration.fillSecondaryContainer,
          padding: EdgeInsets.all(10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total amount',
                style: CustomTextStyles.titleMediumRoboto,
              ),
              FutureBuilder<double>(
                future: DataManager.getTotalBalance(),
                // The method that fetches the total income
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return NumberLoadingAnimation(); // Показать анимацию загрузки
                  } else if (snapshot.hasError) {
                    return Text('Error'); // Handle errors appropriately
                  } else {
                    return AnimatedNumberDisplay(
                        endValue:
                            snapshot.data ?? 0.0); // Отобразить анимацию чисел
                  }
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 8.v),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.h),
                decoration: AppDecoration.fillSecondaryContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total amount',
                      style: CustomTextStyles.titleMediumRoboto,
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
            ),
            SizedBox(width: 8.v),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.h),
                decoration: AppDecoration.fillSecondaryContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Total amount',
                      style: CustomTextStyles.titleMediumRoboto,
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
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildCategories(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            //decoration: AppDecoration.fillPrimary,
            //constraints: BoxConstraints(maxHeight: 150.0),
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
                Tab(text: 'Income'),
                Tab(text: 'Expense'),
              ],
            ),
          ),
          SizedBox(
            height: 8.v,
          ),
          Container(
            height: 225.v,
            child: TabBarView(
              children: [
                FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Две ячейки в ширину
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio:
                              1.3, // Отношение ширины к высоте ячейки
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var item = snapshot.data![index];
                          return TypeCategoryWiget(
                            incomeType: IncomeType.values.elementAt(index + 1),
                          );
                        },
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: getData(isIncome: false),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                          crossAxisCount: 2, // Две ячейки в ширину
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio:
                              1.3, // Отношение ширины к высоте ячейки
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var item = snapshot.data![index];
                          return TypeCategoryWiget(
                            expenseType:
                                ExpenseType.values.elementAt(index + 1),
                            isIncome: false,
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getData({bool isIncome = true}) async {
    List<Map<String, dynamic>> data = [];
    if (isIncome) {
      for (IncomeType type in IncomeType.values) {
        double totalAmount = await DataManager.getTotalIncomesByType(type);
        data.add({
          'typeName': type.toString().split('.').last,
          'amount': totalAmount,
        });
      }
    } else {
      for (ExpenseType type in ExpenseType.values) {
        double totalAmount = await DataManager.getTotalExpensesByType(type);
        data.add({
          'typeName': type.toString().split('.').last,
          'amount': totalAmount,
        });
      }
    }
    data.removeAt(0);
    return data;
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

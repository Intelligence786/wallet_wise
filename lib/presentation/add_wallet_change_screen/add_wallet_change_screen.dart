import 'package:flutter/material.dart';
import 'package:wallet_wise/core/app_export.dart';
import 'package:wallet_wise/data/models/wallet_model/wallet_model.dart';
import 'package:wallet_wise/theme/custom_button_style.dart';
import 'package:wallet_wise/widgets/app_bar/appbar_leading_image.dart';
import 'package:wallet_wise/widgets/app_bar/appbar_title.dart';
import 'package:wallet_wise/widgets/app_bar/custom_app_bar.dart';
import 'package:wallet_wise/widgets/custom_elevated_button.dart';

import '../../data/data_manager.dart';
import '../../widgets/custom_checkbox.dart';
import '../../widgets/custom_text_form_field.dart';

class AddWalletChangeScreen extends StatefulWidget {
  const AddWalletChangeScreen({
    super.key,
    this.isIncome = true,
  });

  static Widget builder(BuildContext context, bool isIncome) {
    return AddWalletChangeScreen(
      isIncome: isIncome,
    );
  }

  final bool isIncome;

  @override
  State<AddWalletChangeScreen> createState() => _AddWalletChangeScreenState();
}

class _AddWalletChangeScreenState extends State<AddWalletChangeScreen> {
  TextEditingController amountController = TextEditingController();

  FocusNode amountNode = FocusNode();

  Map<IncomeType, bool> incomeTypeSelections = {};
  Map<ExpenseType, bool> expenseTypeSelections = {};
  int chooseIndex = -1;
  bool allFieldFills = false;

  @override
  void initState() {
    super.initState();
    chooseIndex = -1;
    // Initialize selection maps
    for (var type in IncomeType.values) {
      if (type == IncomeType.none) {
      } else {
        incomeTypeSelections[type] = false;
      }
    }

    for (var type in ExpenseType.values) {
      if (type == ExpenseType.none) {
      } else {
        expenseTypeSelections[type] = false;
      }
    }
  }

  void fillsTextFields() {
    allFieldFills = amountController.text.isNotEmpty;
  }

  bool checkIsDisabled() {
    setState(() {
      (amountController.text.isEmpty || chooseIndex == -1);
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 50.h,
        leading: AppbarLeadingImage(
          margin: EdgeInsets.all(8.h),
          imagePath: ImageConstant.imgArrowLeft,
          onTap: () => NavigatorService.goBack(),
        ),
        centerTitle: true,
        title: AppbarTitle(
          text: widget.isIncome ? 'Add Income' : 'Add Expense',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 20.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Amount (\$)',
              style: CustomTextStyles.titleMediumRoboto,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.v),
              child: CustomTextFormField(
                onChanged: (value) {
                  if (value == '' || value.length == 1)
                    setState(() {
                      fillsTextFields();
                    });
                },
                textInputType: TextInputType.number,
                textStyle:
                    CustomTextStyles.titleMediumRobotoSecondaryContainer_1,
                hintText: widget.isIncome ? 'Amount Income' : 'Amount Expense',
                hintStyle: CustomTextStyles.titleMediumRobotoSecondaryContainer,
                controller: amountController,
                focusNode: amountNode,
              ),
            ),
            Text(
              widget.isIncome ? 'Income category' : 'Expense category',
              style: CustomTextStyles.titleMediumRoboto,
            ),
            Expanded(
              child: _buildCheckBoxes(),
            ),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 8.h),
      //   child: CustomElevatedButton(
      //     text: widget.isIncome ? 'Add Income' : 'Add Expense',
      //     buttonStyle: CustomButtonStyles.fillPrimary,
      //     height: 48.v,
      //     onPressed: () {},
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildCheckBoxes() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.isIncome
                ? incomeTypeSelections.length
                : expenseTypeSelections.length,
            itemBuilder: (context, index) {
              String option = widget.isIncome
                  ? WalletChangeDataParser.getIncomeTitle(
                      incomeTypeSelections.keys.elementAt(index))
                  : WalletChangeDataParser.getExpenseTitle(
                      expenseTypeSelections.keys.elementAt(index));
              return ListTile(
                minVerticalPadding: 4.v,
                contentPadding: EdgeInsets.zero,
                title: CustomCheckbox(
                  title: option,
                  imagePath: widget.isIncome
                      ? WalletChangeDataParser.getIncomeImageUrl(
                          incomeTypeSelections.keys.elementAt(index))
                      : WalletChangeDataParser.getExpenseImageUrl(
                          expenseTypeSelections.keys.elementAt(index)),
                  height: 55.v,
                  isChecked: chooseIndex == index,
                  onChanged: (_) {
                    setState(() {
                      chooseIndex = index;
                    });

                    print(chooseIndex);
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: 16.v,
          ),
          CustomElevatedButton(
            text: widget.isIncome ? 'Add Income' : 'Add Expense',
            buttonStyle: CustomButtonStyles.fillPrimary,
            height: 50.v,
            isDisabled: !allFieldFills || chooseIndex == -1,
            onPressed: () {
              setState(() {
                widget.isIncome
                    ? DataManager.addToIncomeList(
                        WalletChangeData(
                            changeValue:
                                double.parse(amountController.value.text),
                            incomeType: IncomeType.values[chooseIndex + 1],
                            dateTime: DateTime.now()),
                      )
                    : DataManager.addToExpensesList(
                        WalletChangeData(
                            changeValue:
                                double.parse(amountController.value.text),
                            expenseType: ExpenseType.values[chooseIndex + 1],
                            dateTime: DateTime.now()),
                      );
              });
              NavigatorService.pushNamedAndRemoveUntil(AppRoutes.navigationBarScreen);
            },
          ),
        ],
      ),
    );
  }
}

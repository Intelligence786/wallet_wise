import 'package:flutter/material.dart';
import 'package:wallet_wise/core/app_export.dart';
import 'package:wallet_wise/data/models/wallet_model/wallet_model.dart';

class WalletChangeMainWidget extends StatelessWidget {
  const WalletChangeMainWidget({super.key, required this.walletChangeData});

  final WalletChangeData walletChangeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillSecondaryContainer,
      padding: EdgeInsets.symmetric(vertical: 8.v, horizontal: 8.h),
      child: Row(
        children: [
          Container(
            decoration: AppDecoration.fillSecondaryContainer,
            padding: EdgeInsets.all(8.h),
            child: CustomImageView(
              imagePath: WalletChangeDataParser.getImageUrl(walletChangeData),
            ),
          ),
          SizedBox(
            width: 8.h,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  WalletChangeDataParser.getTitle(walletChangeData),
                  style: CustomTextStyles.titleMediumRobotoSecondaryContainer_1,
                ),
                Text(
                  WalletChangeDataParser.getIsIncome(walletChangeData)
                      ? 'Income'
                      : 'Expense',
                  style: CustomTextStyles.titleSmallSemiBold,
                ),
              ],
            ),
          ),
          Text('\$${walletChangeData.changeValue}')
        ],
      ),
    );
  }
}

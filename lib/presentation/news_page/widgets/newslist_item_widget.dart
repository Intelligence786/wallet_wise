import 'package:flutter/material.dart';
import 'package:wallet_wise/data/models/news_model/news_model.dart';
import 'package:wallet_wise/theme/custom_button_style.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
// ignore_for_file: must_be_immutable
class NewslistItemWidget extends StatelessWidget {
  NewslistItemWidget({
    Key? key,
    required this.newsModel,
  }) : super(
          key: key,
        );
  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomImageView(
              imagePath: newsModel.imgUrl!,
              height: 120.adaptSize,
              width: 120.adaptSize,
              radius: BorderRadius.circular(
                12.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 220.h,
                    child: Text(
                      newsModel.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleMediumSecondaryContainer_1
                          .copyWith(
                        height: 1.38,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 44.v,
                  ),
                  _buildButtonText(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildButtonText(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        NavigatorService.pushNamed(AppRoutes.newsScreen, arguments: newsModel);
      },
      buttonStyle: CustomButtonStyles.fillNewsButton,
      width: 118.h,
      text: 'Open news',
      buttonTextStyle: CustomTextStyles.titleMediumPrimary,
    );
  }
}

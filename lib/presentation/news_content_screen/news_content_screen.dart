
import 'package:flutter/material.dart';
import 'package:wallet_wise/core/app_export.dart';

import '../../data/models/news_model/news_model.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class NewsContentScreen extends StatefulWidget {
  final NewsModel newsModel;

  const NewsContentScreen({super.key, required this.newsModel});

  static Widget builder(BuildContext context, NewsModel newsModel) {
    return NewsContentScreen(
      newsModel: newsModel,
    );
  }

  @override
  State<NewsContentScreen> createState() => _NewsContentScreenState();
}

class _NewsContentScreenState extends State<NewsContentScreen> {
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
          text: 'News',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Expanded(
            child: SingleChildScrollView(
              child: Container(
               // padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // SizedBox(height: 13.v),
                    CustomImageView(
                        fit: BoxFit.fill,
                        imagePath: widget.newsModel.imgUrl,
                       ),

                    SizedBox(height: 20.v),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.h),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(widget.newsModel.title!,
                              style: theme.textTheme.headlineSmall)),
                    ),
                    SizedBox(height: 20.v),
                    Container(
                      //  width: 334.h,
                      margin: EdgeInsets.symmetric(horizontal: 12.h),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: widget.newsModel.body,
                                style: CustomTextStyles
                                    .titleMediumSecondaryContainer18),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

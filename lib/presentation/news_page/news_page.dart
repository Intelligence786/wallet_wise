import 'package:flutter/material.dart';
import 'package:wallet_wise/presentation/news_page/widgets/newslist_item_widget.dart';

import '../../core/app_export.dart';
import '../../data/data_manager.dart';
import '../../data/models/news_model/news_model.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsModel> newsListCurrent = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsListCurrent = DataManager.getAllNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBottomWiget(context));
  }

  Widget _buildBottomWiget(BuildContext context) {
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
              'News',
              style: theme.textTheme.headlineLarge,
            ),
            SizedBox(height: 8.v),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: newsListCurrent.length,
                      itemBuilder: (context, index) {
                        NewsModel news = newsListCurrent[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.v),
                          child: NewslistItemWidget(
                            newsModel: news,
                          ),
                        );
                      },
                    ),
                  ),
                  /*    SizedBox(
                  height: 60.h,
                ),*/
                ],
              ),
              //height: 200.h,
            ),
            SizedBox(
              height: 80.v,
            )
          ],
        ),
      ),
    );
  }
}

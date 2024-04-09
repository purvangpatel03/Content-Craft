import 'dart:typed_data';
import 'package:article_web/modules/update_article/appbar/update_article_appbar.dart';
import 'package:article_web/modules/update_article/widgets/update_article_body.dart';
import 'package:article_web/provider/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/article/article_model.dart';

class UpdateArticlePage extends StatefulWidget {
  ArticleModel articleModel;

  UpdateArticlePage({super.key, required this.articleModel});

  @override
  State<UpdateArticlePage> createState() => _UpdateArticlePageState();
}

class _UpdateArticlePageState extends State<UpdateArticlePage> {
  late BuildContext consumerContext;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<ArticleProvider>(consumerContext, listen: false)
            .selectArticle(widget.articleModel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleProvider(),
      child: Consumer<ArticleProvider>(builder: (context, provider, child) {
        consumerContext = context;
        return Scaffold(
          appBar: UpdateArticleAppbar(provider.selectedArticle),
          body: UpdateArticleBody(provider.selectedArticle),
        );
      }),
    );
  }
}

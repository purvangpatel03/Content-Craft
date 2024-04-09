import 'package:article_web/modules/article/appbar/article_appbar.dart';
import 'package:flutter/material.dart';
import '../../models/article/article_model.dart';
import 'widgets/article_body.dart';

class ArticlePage extends StatelessWidget {
  ArticleModel articleModel;

  ArticlePage(
      {super.key,
        required this.articleModel
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArticleAppbar(
        articleModel: articleModel,
      ),
      body: ArticleBody(
        title: articleModel.title,
        description: articleModel.description,
        image: articleModel.image!,
      ),
    );
  }
}

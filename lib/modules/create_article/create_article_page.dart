import 'dart:typed_data';

import 'package:article_web/provider/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appbar/create_article_appbar.dart';
import 'widgets/create_article_body.dart';

class CreateArticlePage extends StatefulWidget {
  const CreateArticlePage({super.key});

  @override
  State<CreateArticlePage> createState() => _CreateArticlePageState();
}

class _CreateArticlePageState extends State<CreateArticlePage> {
  Uint8List? image;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArticleProvider(),
      child: Scaffold(
        appBar: CreateArticleAppbar(
          webImage: image,
          titleController: titleController,
          descriptionController: descriptionController,
        ),
        body: CreateArticleBody(
          image: (webImage){
            setState(() {
              image = webImage;
            });
          },
          titleController: titleController,
          descriptionController: descriptionController,
        ),
      ),
    );
  }
}

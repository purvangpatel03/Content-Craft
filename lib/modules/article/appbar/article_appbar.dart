import 'package:article_web/modules/home/home_page.dart';
import 'package:article_web/modules/update_article/update_article_page.dart';
import 'package:article_web/provider/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../models/article/article_model.dart';

class ArticleAppbar extends StatelessWidget implements PreferredSizeWidget {
  ArticleModel articleModel;

  ArticleAppbar({super.key, required this.articleModel});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _backButton(context),
      actions: [
        _updateButton(context),
        _deleteButton(context),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _backButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
      icon: const Icon(Icons.arrow_back_outlined),
    );
  }

  _updateButton(BuildContext context) {
    if (ArticleProvider.isAdmin) {
      return IconButton(
        onPressed: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateArticlePage(
                articleModel: articleModel,
              ),
            ),
          );
        },
        icon: const Row(
          children: [
            Icon(Icons.edit),
            Text(
              'Update',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              width: 2,
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  _deleteButton(BuildContext context) {
    if (ArticleProvider.isAdmin) {
      return SizedBox(
        height: 40,
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.all(0),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          onPressed: () async {
            await ArticleProvider().deleteArticle(articleModel.docId!);
            if (context.mounted) {
              showDialogBox(context);
            }
          },
          child: const Text('Delete'),
        ),
      );
    }
    return const SizedBox();
  }

  Future showDialogBox(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            elevation: 8,
            title: const Text("Article Deleted Successfully"),
            content: Lottie.asset(
              height: 200,
              'assets/lottie/article_delete/delete_article.json',
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () async{
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: const Text("Done"),
              ),
            ],
          );
        });
  }
}

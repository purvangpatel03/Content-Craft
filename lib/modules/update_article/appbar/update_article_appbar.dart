import 'dart:typed_data';

import 'package:article_web/modules/home/home_page.dart';
import 'package:article_web/provider/article_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../models/article/article_model.dart';

class UpdateArticleAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final ArticleModel? selectedArticle;

  const UpdateArticleAppbar(
    this.selectedArticle, {
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _backButton(context),
      actions: [
        SizedBox(
          height: 40,
          width: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.all(0),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white),
            onPressed: () async {
              try {
                await ArticleProvider().updateArticle(
                  selectedArticle!.title,
                  selectedArticle!.description,
                  selectedArticle!.docId!,
                  selectedArticle!.image!,
                );
                if (context.mounted) {
                  showDialogBox(context);
                }
              } on FirebaseException catch (e) {
                print(e);
              }
            },
            child: const Text('Publish'),
          ),
        ),
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

  Future showDialogBox(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          elevation: 8,
          title: const Text("Article Updated Successfully"),
          content: Lottie.asset(
            height: 200,
            'assets/lottie/article_added/article_added.json',
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              onPressed: () {
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
      },
    );
  }
}

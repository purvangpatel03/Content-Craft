import 'dart:typed_data';

import 'package:article_web/modules/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../models/article/article_model.dart';
import '../../../provider/article_provider.dart';

class CreateArticleAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  Uint8List? webImage;
  TextEditingController titleController;
  TextEditingController descriptionController;

  CreateArticleAppbar({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.webImage,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: IconButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
        icon: const Icon(
          Icons.arrow_back_outlined,
        ),
      ),
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
              String time = DateTime.now().toString().replaceAll(' ', '');
              try {
                if (webImage != null) {
                  final mountRef = storageRef.child('article_images/$time.jpg');
                  mountRef.putData(webImage!);
                  var path = mountRef.putData(webImage!).snapshot.ref.fullPath;
                  print(path);
                  await Provider.of<ArticleProvider>(context, listen: false)
                      .addArticle(
                    ArticleModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      dateTime: time,
                      imagePath: path,
                    ),
                  );
                  descriptionController.clear();
                  titleController.clear();
                  if (context.mounted) {
                    showDialogBox(context);
                  }
                }
              } on FirebaseException catch (e) {
                print(e.message);
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

  Future showDialogBox(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          elevation: 8,
          title: const Text("Article Added Successfully"),
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

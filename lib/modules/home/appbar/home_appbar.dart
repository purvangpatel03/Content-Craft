import 'package:article_web/modules/create_article/create_article_page.dart';
import 'package:article_web/modules/main/main_page.dart';
import 'package:article_web/provider/article_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Image(
        height: 36,
        image: AssetImage('assets/logo/sidevise_logo.png'),
      ),
      actions: [
        _writeButton(context),
        _signOutButton(context),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }

  _writeButton(BuildContext context) {
    if (ArticleProvider.isAdmin!) {
      return IconButton(
        onPressed: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateArticlePage(),
            ),
          );
        },
        icon: const Row(
          children: [
            Icon(Icons.edit),
            Text(
              'Write',
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

  _signOutButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.remove('email');
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
          );
        }
      },
      icon: const Icon(Icons.exit_to_app),
    );
  }
}

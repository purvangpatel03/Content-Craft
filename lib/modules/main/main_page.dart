import 'package:article_web/modules/home/home_page.dart';
import 'package:article_web/modules/login_and_signup/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/article_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future setPreference(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('email', email);
    if (email == 'purvang@gmail.com') {
      ArticleProvider.isAdmin = true;
    } else {
      ArticleProvider.isAdmin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return FutureBuilder(
            future: setPreference(FirebaseAuth.instance.currentUser!.email!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const HomePage();
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}

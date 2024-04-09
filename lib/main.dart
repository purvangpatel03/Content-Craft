import 'dart:io';
import 'package:article_web/modules/home/home_page.dart';
import 'package:article_web/modules/main/main_page.dart';
import 'package:article_web/themes/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyC4N43YmaJf2PKDcKpQK3lg4kA6tVv57R8',
        appId: '1:725227720753:web:79ec3e7a66c492c9f54510',
        messagingSenderId: '725227720753',
        projectId: 'content-craft-project',
        authDomain: 'content-craft-project.firebaseapp.com',
        storageBucket: 'content-craft-project.appspot.com',
        measurementId: 'G-WE52K082BK',
      ),
    );
  } else if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyC4N43YmaJf2PKDcKpQK3lg4kA6tVv57R8',
        appId: '1:725227720753:android:c88db0269ebfd9e4f54510',
        messagingSenderId: '725227720753',
        projectId: 'content-craft-project',
        authDomain: 'content-craft-project.firebaseapp.com',
        storageBucket: 'content-craft-project.appspot.com',
        measurementId: 'G-WE52K082BK',
      ),
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? loginEmail;

  Future getPreference() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      loginEmail = pref.getString('email');
      print(loginEmail);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPreference(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: myTheme,
              home: loginEmail != null ? const HomePage() : const MainPage(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
    );
  }
}

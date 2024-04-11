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
        apiKey: 'your Api key',
      appId: 'your app id',
      messagingSenderId: 'your messagingSenderId',
      projectId: 'your projectId',
      storageBucket: 'your storageBucket',
        authDomain: 'your auth domian',
        measurementId: 'your measurement id',
      ),
    );
  } else if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
       apiKey: 'your Api key',
      appId: 'your app id',
      messagingSenderId: 'your messagingSenderId',
      projectId: 'your projectId',
      storageBucket: 'your storageBucket',
        authDomain: 'your auth domian',
        measurementId: 'your measurement id',
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

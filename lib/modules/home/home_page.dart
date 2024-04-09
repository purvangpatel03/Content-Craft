import 'package:article_web/provider/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appbar/home_appbar.dart';
import 'widgets/home_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArticleProvider(),
      child: const Scaffold(
        appBar: HomeAppBar(),
        body: HomeList(),
      ),
    );
  }
}

import 'package:article_web/custom_widgets/responsive_widget.dart';
import 'package:article_web/models/article/article_model.dart';
import 'package:article_web/modules/article/article_page.dart';
import 'package:article_web/provider/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class HomeList extends StatelessWidget {
  const HomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder: (context, provider, child) {
        if (provider.articles.isEmpty) {
          provider.getArticles();
          return Center(
            child: LoadingAnimationWidget.flickr(
              leftDotColor: Colors.amberAccent,
              rightDotColor: Colors.black,
              size: 36,
            ),
          );
        } else {
          return ResponsiveWidget(
            builder: (type) {
              if (type == DeviceType.WEB) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 4.5,
                    children: List.generate(
                      provider.articles.length,
                      (index) => InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticlePage(
                                articleModel: provider.articles[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.3,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          provider.articles[index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          maxLines: 4,
                                          provider.articles[index].description,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 160,
                                height: MediaQuery.sizeOf(context).width/4.5,
                                child: articleImage(
                                  provider.articles[index],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 1,
                    childAspectRatio: 2.6,
                    children: List.generate(
                      provider.articles.length,
                      (index) => InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticlePage(
                                articleModel: provider.articles[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.3,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        provider.articles[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        maxLines: 3,
                                        provider.articles[index].description,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                height: MediaQuery.sizeOf(context).width/3,
                                child: articleImage(
                                  provider.articles[index],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  articleImage(ArticleModel articleModel) {
    if (articleModel.image != null) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: Image.memory(
          articleModel.image!,
          fit: BoxFit.cover,
        ),
      );
    }
    return const ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      child: Image(
        fit: BoxFit.cover,
        image: AssetImage('assets/home/default_article.png'),
      ),
    );
  }
}

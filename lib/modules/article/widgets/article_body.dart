import 'dart:typed_data';
import 'package:article_web/custom_widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

class ArticleBody extends StatelessWidget {
  final String title;
  final String description;
  final Uint8List image;

  const ArticleBody({super.key, required this.title, required this.description, required this.image});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (type){
        if(type == DeviceType.WEB){
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20, horizontal: MediaQuery.sizeOf(context).width / 3.5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height/2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: _getImage()
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    height: MediaQuery.sizeOf(context).height/2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _getImage(),
                  ),
                ),
                const SizedBox(height: 26),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _getImage() {
    return Image.memory(
      image,
      fit: BoxFit.contain,
      height: 200,
    );
  }
}

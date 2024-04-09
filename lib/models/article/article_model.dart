import 'dart:typed_data';

class ArticleModel {
  String title;
  String description;
  Uint8List? image;
  String? userId;
  String? docId;
  String dateTime;
  String? imagePath;

  ArticleModel(
      {required this.title,
      required this.description,
      this.image,
      required this.userId,
      this.docId,
      required this.dateTime,
      this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'userId': userId,
      'dateTime': dateTime,
      'imagePath': imagePath,
    };
  }

  static ArticleModel fromMap(Map<String, dynamic> article) {
    return ArticleModel(
      title: article['title'],
      description: article['description'],
      userId: article['userId'],
      docId: article['docId'],
      dateTime: article['dateTime'],
      imagePath: article['imagePath'],
    );
  }
}

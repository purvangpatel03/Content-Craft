import 'dart:typed_data';

import 'package:article_web/firebase/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/article/article_model.dart';

class ArticleProvider with ChangeNotifier{
  List<ArticleModel> articles = [];
  ArticleModel? selectedArticle;

  static bool isAdmin = false;

  addArticle(ArticleModel article) async{
    await FirebaseHelper().insertArticle(article);
    notifyListeners();
  }

  selectArticle(ArticleModel articleModel){
    selectedArticle = articleModel;
    notifyListeners();
  }

  getArticles() async {
    articles = await FirebaseHelper().getArticles();
    notifyListeners();
  }

  deleteArticle(String docId) async{
    await FirebaseHelper().deleteArticle(docId);
    notifyListeners();
  }


  updateArticle(String title, String description, String docId, Uint8List newImage) async{
    await FirebaseHelper().updateArticle(title, description, docId, newImage);
    notifyListeners();
  }

  updateImage() async{
    final ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if(image != null){
      selectedArticle?.image = await image.readAsBytes();
      notifyListeners();
    }
  }

}
import 'dart:async';
import 'dart:typed_data';
import 'package:article_web/models/article/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseHelper {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('articles');
  
  final storageRef = FirebaseStorage.instance.ref();

  Uint8List? image;

  Future insertArticle(ArticleModel article) async {
    await collectionReference.add(
      article.toMap(),
    );
  }

  Future updateArticle(String title, String description,String docId, Uint8List newImage) async{
    var item = await collectionReference.doc(docId).get();
    await storageRef.child(item['imagePath']).delete();
    await storageRef.child(item['imagePath']).putData(newImage);
    await collectionReference.doc(docId).update(
      {
        'title': title,
        'description': description,
      }
    );
  }

  Future deleteArticle(String docId) async {
    var item = await collectionReference.doc(docId).get();
    var imagePath = item['imagePath'].toString();
    await collectionReference.doc(docId).delete();
    await storageRef.child(imagePath).delete();
  }

  Future<List<ArticleModel>> getArticles() async {

    final QuerySnapshot querySnapshot = await collectionReference.get();
    final articles = <ArticleModel>[];

    for (final doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
       try{
         final downloadRef = storageRef.child(data['imagePath']);
         image = await downloadRef.getData();
         final article = ArticleModel(
           dateTime: data['dateTime'],
           image: image,
           title: data['title'],
           description: data['description'],
           userId: FirebaseAuth.instance.currentUser?.uid,
           docId: doc.id,
           imagePath: data['imagePath'],
         );
         articles.add(article);
       }on  FirebaseException catch(e){
         print(e.message);
      }
    }
   return articles;
  }

}

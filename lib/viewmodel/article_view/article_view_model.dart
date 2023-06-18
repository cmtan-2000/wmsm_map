import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ArticleViewModel extends ChangeNotifier {
  //properties
  String _author = '';
  String _title = '';
  String _publishDate = '';
  String _imgPath = '';
  String _content = '';

  List<Map<String, dynamic>> articles = [];

  //setter
  void setArticle(String author, String title, String publishDate,
      String imgPath, String content) {
    _author = author;
    _title = title;
    _imgPath = imgPath;
    _publishDate = publishDate;
    _content = content;
  }

  //getter
  String get author => _author;
  String get title => _title;
  String get publishDate => _publishDate;
  String get imgPath => _imgPath;
  String get content => _content;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> articleStream =
      FirebaseFirestore.instance.collection('article').snapshots();

  //get data from database
  void getData() async {
    // articleStream.listen((QuerySnapshot snapshot) {
    //   articles = snapshot.docs.map((DocumentSnapshot doc) {
    //     return doc.data() as Map<String, dynamic>;
    //   }).toList();
    // });

    await FirebaseFirestore.instance.collection('article').get().then((value) {
      articles = value.docs.map((DocumentSnapshot doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    });

    notifyListeners();
  }

  //save data to the database
  Future<void> saveData() async {
    final newArticle = {
      'author': _author,
      'title': _title,
      'publishDate': _publishDate,
      'imgPath': _imgPath,
      'content': _content,
    };

    final docRef = await firestore.collection('article').add(newArticle);

    //update the local articles list
    articles.add(newArticle);

    notifyListeners();
    Logger().i('Data saved successfully with ID: ${docRef.id}');
  }
}

// ignore_for_file: invalid_return_type_for_catch_error

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

  void getData() async {
    articles.clear();
    await FirebaseFirestore.instance.collection('article').get().then((value) {
      articles = value.docs.map((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final docid = doc.id;
        return {'id': docid, ...data};
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
    firestore.collection('article').add(newArticle).then((value) {
      getData();
      notifyListeners();
      Logger().i('Data saved successfully with ID: ${value.id}');
    });
  }

  Future<void> updateData(String id) async {
    final docid = id;
    final updatedArticle = {
      'author': _author,
      'title': _title,
      'publishDate': _publishDate,
      'imgPath': _imgPath,
      'content': _content,
    };

    firestore
        .collection('article')
        .doc(docid)
        .update(updatedArticle)
        .then((value) {
      getData();
      notifyListeners();
      Logger().i('Data updated successfully with ID: $docid');
    }).catchError((error) => Logger().e('Failed to update data: $error'));
  }

  Future<void> deleteData(String id) async {
    final docid = id;
    firestore.collection('article').doc(docid).delete().then((value) {
      getData();
      notifyListeners();
      Logger().i('Data deleted successfully with ID: $docid');
    }).catchError((error) => Logger().e('Failed to delete data: $error'));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String id;
  final String author;
  final String title;
  final String publishDate;
  final String imgPath;
  final String content;

  Article(
      {
      required this.id,
      required this.author,
      required this.title,
      required this.publishDate,
      required this.imgPath,
      required this.content});

  Article.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = json['author'],
        title = json['title'],
        publishDate = json['publishDate'],
        imgPath = json['imgPath'],
        content = json['content'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author,
        'title': title,
        'publishDate': publishDate,
        'imgPath': imgPath,
        'content': content,
      };

  factory Article.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Article(
      id: snapshot.id,
      author: data['author'],
      title: data['title'],
      publishDate: data['publishDate'],
      imgPath: data['imgPath'],
      content: data['content'],
    );
  }
}

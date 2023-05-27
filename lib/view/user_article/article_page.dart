// This is article page

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wmsm_flutter/main.dart';

import '../../model/users.dart';
import '../../viewmodel/shared/shared_pref.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  Users user = Users(
      dateOfBirth: '',
      email: '',
      fullname: '',
      phoneNumber: '',
      username: '',
      role: '');
  SharedPref sharedPref = SharedPref();

  @override
  initState() {
    super.initState();
    initialGetSavedData();
  }

  void initialGetSavedData() async {
    Users response = Users.fromJson(await sharedPref.read("user"));
    setState(() {
      user = Users(
          dateOfBirth: response.dateOfBirth,
          email: response.email,
          fullname: response.fullname,
          phoneNumber: response.phoneNumber,
          role: response.role,
          username: response.username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            title:
                Text('Article', style: Theme.of(context).textTheme.bodyLarge),
            automaticallyImplyLeading: false,
          ),
          SliverToBoxAdapter(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              ArticleListPage(
                articleTitle: 'How to Exercise Daily',
                articleAuthor: 'Naruto',
                articlePublishDate: '2023-05-18',
                articleImage:
                    'https://images.unsplash.com/flagged/photo-1556746834-cbb4a38ee593?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=872&q=80',
              ),
              ArticleListPage(
                articleTitle: 'Walk n Run Program',
                articleAuthor: 'Hinata',
                articlePublishDate: '2023-05-18',
                articleImage:
                    'https://images.unsplash.com/photo-1674574124649-778f9afc0e9c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
              ),
              ArticleListPage(
                articleTitle: 'WMSM App Changing Lives',
                articleAuthor: 'Sasuke',
                articlePublishDate: '2023-05-18',
                articleImage:
                    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=481&q=80',
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class ArticleListPage extends StatelessWidget {
  const ArticleListPage({
    super.key,
    required this.articleTitle,
    required this.articleAuthor,
    required this.articlePublishDate,
    required this.articleImage,
  });

  final String articleTitle;
  final String articleAuthor;
  final String articlePublishDate;
  final String articleImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //TODO: Lead to new page
      onTap: () {
        MyApp.navigatorKey.currentState!.pushNamed('/articleDetails');
      },
      child: SizedBox(
        //width and height for entire container article
        width: MediaQuery.of(context).size.width * 0.8,
        height: 240,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              //TODO: Article image
              //?width and height specifically for img, any img size can fit
              child: CachedNetworkImage(
                imageUrl: articleImage,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.8,
                height: 150,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(articleTitle,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Author: $articleAuthor',
                    style: Theme.of(context).textTheme.bodySmall),
                Text('Date: $articlePublishDate',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

// This is article page

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/model/article.dart';
import 'package:wmsm_flutter/viewmodel/article_view/article_view_model.dart';

import '../../model/users.dart';
import '../../viewmodel/shared/shared_pref.dart';
import '../../viewmodel/user_view_model.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<Map<String, dynamic>> articles = [];

  Users user = Users(
      dateOfBirth: '',
      email: '',
      fullname: '',
      phoneNumber: '',
      username: '',
      role: '');
  // SharedPref sharedPref = SharedPref();

  @override
  initState() {
    super.initState();
    initialGetSavedData();
  }

  void initialGetSavedData() async {
    // Users response = Users.fromJson(await sharedPref.read("user"));

    final response = Provider.of<UserViewModel>(context, listen: false).user;
    Provider.of<ArticleViewModel>(context, listen: false).getData();

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

  FloatingActionButton? floatingbutton(String role) {
    if (role == 'user') {
      //return nothing
      return null;
    }
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/manageArticle');
      },
      backgroundColor: Colors.blueGrey,
      tooltip: 'Add new article',
      child: const Icon(LineAwesomeIcons.plus, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    // for (var article in articles) {
    //   Logger().i(article['title']);
    //   Logger().i(article['author']);
    //   Logger().i(article['publishDate']);
    // }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            title:
                Text('Article', style: Theme.of(context).textTheme.bodyLarge),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  MyApp.navigatorKey.currentState!.pushNamed('/searchArticle');
                },
                icon: const Icon(LineAwesomeIcons.search),
              ),
            ],
          ),
          Consumer<ArticleViewModel>(
            builder: (context, articleViewModel, child) {
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //*turn this into listview builder
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          itemCount: articleViewModel.articles.length,
                          itemBuilder: (context, index) {
                            // Get list article from database
                            articles = articleViewModel.articles;
                            var article = articles[index];

                            return Center(
                              child: ArticleListPage(
                                articleAuthor: article['author'],
                                articleImage: article['imgPath'],
                                articlePublishDate: article['publishDate'],
                                articleTitle: article['title'],
                                articleContent: article['content'],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: floatingbutton(user.role),
    );
  }
}

class ArticleListPage extends StatelessWidget {
  ArticleListPage({
    super.key,
    required this.articleTitle,
    required this.articleAuthor,
    required this.articlePublishDate,
    required this.articleImage,
    required this.articleContent,
  });

  final String articleTitle;
  final String articleAuthor;
  final String articlePublishDate;
  final String articleImage;
  final String articleContent;
  late SharedPref sharedPref = SharedPref();

  Future<void> storeData() async {
    Article article = Article(
        title: articleTitle,
        author: articleAuthor,
        imgPath: articleImage,
        content: articleContent,
        publishDate: articlePublishDate);

    sharedPref.save("article", article.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //pass object article to next page
        await storeData();
        Article article1 = Article.fromJson(await sharedPref.read("article"));
        Logger().i(article1);
        MyApp.navigatorKey.currentState!
            .pushNamed('/articleDetails', arguments: article1);
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
            const SizedBox(
              height: 5,
            ),
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

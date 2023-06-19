import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/model/article.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/viewmodel/article_view/article_view_model.dart';

class SearchArticlePage extends StatefulWidget {
  const SearchArticlePage({super.key});

  @override
  State<SearchArticlePage> createState() => _SearchArticlePageState();
}

class _SearchArticlePageState extends State<SearchArticlePage> {
  late TextEditingController _searchController;
  List<Map<String, dynamic>> searchResult = [];
  late Article article1;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    Provider.of<ArticleViewModel>(context, listen: false).getData();
    searchResult =
        Provider.of<ArticleViewModel>(context, listen: false).articles;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text('Search Article',
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          Consumer<ArticleViewModel>(
              builder: (context, articleViewmodel, child) {
            return SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextFormField(
                            context: context,
                            controller: _searchController,
                            hintText: 'WMSM App Changing Lives',
                            suffixicon: IconButton(
                              onPressed: () {
                                _searchController.clear();
                                articleViewmodel.searchArticle('');
                              },
                              icon: const Icon(Icons.clear),
                            ),
                            textInputAction: TextInputAction.search,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              articleViewmodel.searchArticle(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            })),
                    Expanded(
                      child: articleViewmodel.searchResult.isNotEmpty &&
                              _searchController.text.isNotEmpty
                          //!display keyword
                          ? ListView.separated(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              itemCount: articleViewmodel.searchResult.length,
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(articleViewmodel
                                      .searchResult[index]['title']),
                                  subtitle: Text(
                                      "Author: ${articleViewmodel.searchResult[index]['author']}",
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                  onTap: () {
                                    article1 = Article(
                                        id: articleViewmodel.searchResult[index]
                                            ['id'],
                                        title: articleViewmodel
                                            .searchResult[index]['title'],
                                        author: articleViewmodel
                                            .searchResult[index]['author'],
                                        content: articleViewmodel
                                            .searchResult[index]['content'],
                                        imgPath: articleViewmodel
                                            .searchResult[index]['imgPath'],
                                        publishDate: articleViewmodel
                                            .searchResult[index]['publishDate'],
                                        eventDate: articleViewmodel
                                            .searchResult[index]['eventDate']);

                                    MyApp.navigatorKey.currentState!.pushNamed(
                                        '/articleDetails',
                                        arguments: article1);
                                  },
                                );
                              },
                            )

                          //if no matching result when type is not found
                          : _searchController.text.isNotEmpty
                              ? const Text('No matching result')

                              //!display all
                              : ListView.separated(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  itemCount: articleViewmodel.articles.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(articleViewmodel
                                          .articles[index]['title']),
                                      subtitle: Text(
                                          articleViewmodel.articles[index]
                                              ['author'],
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 12)),
                                      onTap: () {
                                        article1 = Article(
                                          id: articleViewmodel.articles[index]
                                              ['id'],
                                          title: articleViewmodel
                                              .articles[index]['title'],
                                          author: articleViewmodel
                                              .articles[index]['author'],
                                          content: articleViewmodel
                                              .articles[index]['content'],
                                          imgPath: articleViewmodel
                                              .articles[index]['imgPath'],
                                          publishDate: articleViewmodel
                                              .articles[index]['publishDate'],
                                          eventDate: articleViewmodel
                                              .articles[index]['eventDate'],
                                        );

                                        MyApp.navigatorKey.currentState!
                                            .pushNamed('/articleDetails',
                                                arguments: article1);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

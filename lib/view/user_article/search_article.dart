import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  //call this function to run the filter
  // void _runFilter(String enteredKeyword) {
  //   List<Map<String, dynamic>> results = [];

  //   results = searchResult
  //       .where((article) => article['title']
  //           .toLowerCase()
  //           .contains(enteredKeyword.toLowerCase()))
  //       .toList();

  //   Logger().wtf(results);

  //   // // Refresh the UI
  //   // setState(() {
  //   //   searchResult = results;

  //   // });
  // }

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
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: CustomTextFormField(
                            context: context,
                            controller: _searchController,
                            hintText: 'Ex WMSM App Changing Lives',
                            suffixicon: IconButton(
                              onPressed: () {
                                _searchController.clear();
                                // articleViewmodel.searchArticle('');
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
                      child: articleViewmodel.searchResult.isNotEmpty ||
                              _searchController.text.isNotEmpty
                          //*display keyword
                          ? ListView.builder(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              itemCount: articleViewmodel.searchResult.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(articleViewmodel
                                      .searchResult[index]['title']),
                                  subtitle: Text(articleViewmodel
                                      .searchResult[index]['author']),
                                  // onTap: MyApp.navigatorKey.currentState!.pushNamed('/articleDetails', arguments: article1);
                                );
                              },
                            )
                          //*display all
                          : ListView.builder(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              itemCount: articleViewmodel.articles.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(articleViewmodel.articles[index]
                                      ['title']),
                                  subtitle: Text(articleViewmodel
                                      .articles[index]['author']),
                                );
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

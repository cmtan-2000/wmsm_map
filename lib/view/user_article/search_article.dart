import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';

class SearchArticlePage extends StatefulWidget {
  const SearchArticlePage({super.key});

  @override
  State<SearchArticlePage> createState() => _SearchArticlePageState();
}

class _SearchArticlePageState extends State<SearchArticlePage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
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
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: CustomTextFormField(
                        context: context,
                        controller: _searchController,
                        hintText: 'Ex WMSM App Chaning Lives',
                        suffixicon: IconButton(
                          onPressed: () => _searchController.clear(),
                          icon: const Icon(Icons.clear),
                        ),
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        })),
  

              ],
            ),
          ),
        ],
      ),
    );
  }
}

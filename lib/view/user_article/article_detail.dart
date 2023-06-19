import 'package:flutter/material.dart';
import 'package:wmsm_flutter/model/article.dart';

class ArticleDetails extends StatelessWidget {
  const ArticleDetails({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text(article.title,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      article.imgPath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                    Positioned(
                      bottom: 10,
                      left: 20,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(article.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Author: ${article.author}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.white),
                              ),
                              Text(
                                article.publishDate,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        '[Event date: ${article.eventDate}]\n\n${article.content}',
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

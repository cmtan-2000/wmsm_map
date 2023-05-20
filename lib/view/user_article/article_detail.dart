import 'package:flutter/material.dart';

class ArticleDetails extends StatelessWidget {
  const ArticleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            //TODO:
            title: Text('How to Exercise Daily',
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      'https://images.unsplash.com/flagged/photo-1556746834-cbb4a38ee593?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=872&q=80',
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
                          //TODO: Article article
                          Text('How to Exercise Daily',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                          //TODO: Article author
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Author: biubiu',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.white),
                              ),
                              //TODO: Article date
                              Text(
                                'Date: 18/5/2023',
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
                      //TODO: Article content
                      child: const Text(
                        'SINGAPORE — On Monday (Dec 26), Mr Sim Boh Huat finally completed a mural in a neighbourhood square in Bedok using 80,000 plastic bottle caps, capping six months of effort that the 77-year-old retiree put in almost every day. And right off the bat, Mr Sim has set his sights on his next project. While he is still discussing the details with the authorities, such as the location of the next mural, Mr Sim told TODAY on Tuesday that he hopes that it will be in the shape of a Merlion, also using plastic bottle caps. ',
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

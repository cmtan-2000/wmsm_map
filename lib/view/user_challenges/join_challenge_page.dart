import 'package:flutter/material.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/model/new_challenge.dart';

import 'join_challenge_details.dart';

class JoinChallengePage extends StatelessWidget {
  JoinChallengePage({super.key});

  List<NewChallenge> listOfNewChallenge = [challenge1, challenge2, challenge3];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          title: Text('Join Challenge',
              style: Theme.of(context).textTheme.bodyLarge),
          automaticallyImplyLeading: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            //?Yellow container
            color: Theme.of(context).primaryColor,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                //!CRUD JOIN CHALLENGE LIST CARD
                Expanded(
                  child: ListView.builder(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      itemCount: listOfNewChallenge.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            onTap: () {
                              MyApp.navigatorKey.currentState!.push(
                                MaterialPageRoute(
                                  builder: (context) => JoinChallengeDetails(
                                    challengeTitle: listOfNewChallenge[index]
                                        .newChallangeTitle,
                                    challengeDesc: listOfNewChallenge[index]
                                        .newChallengeDesc,
                                    challengeEventDuration:
                                        listOfNewChallenge[index]
                                            .newChallengeEventDuration,
                                    challengeImgPath: listOfNewChallenge[index]
                                        .newChallengeImgPath,
                                    challengeSteps: listOfNewChallenge[index]
                                        .newChallengeSteps,
                                    challengeVoucher: listOfNewChallenge[index]
                                        .newChallengeVoucher,
                                  ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              foregroundImage: AssetImage(
                                  listOfNewChallenge[index]
                                      .newChallengeImgPath),
                              backgroundColor: Colors.transparent,
                              radius: 25,
                            ),
                            title: Text(
                                listOfNewChallenge[index].newChallangeTitle),
                            subtitle: Text(
                                listOfNewChallenge[index]
                                    .newChallengeEventDuration,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.teal)),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// This is challenge page
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

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
              child: Container(
            color: Theme.of(context).primaryColor,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Card(
                  elevation: 2,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ongoing Challenge',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //! TODO: CRUD ONGOING CHALLENGE!!
                          const OngoingChallengeCard(
                            ongoingTitle: 'Walk 100 miles',
                            ongoingImgPath: 'assets/images/challenge1.png',
                            ongoingPercentage: 0.6,
                            ongonigSteps: 600,
                            challengeSteps: 1000,
                          ),
                          const OngoingChallengeCard(
                            ongoingTitle: 'Walk for 30 minutes everyday',
                            ongoingImgPath: 'assets/images/challenge2.png',
                            ongoingPercentage: 0.6,
                            ongonigSteps: 600,
                            challengeSteps: 1000,
                          ),
                          const OngoingChallengeCard(
                            ongoingTitle: 'Burn 100 calories per day',
                            ongoingImgPath: 'assets/images/challenge3.png',
                            ongoingPercentage: 0.6,
                            ongonigSteps: 600,
                            challengeSteps: 1000,
                          ),
                          //!
                          const SizedBox(height: 20),
                          CustomOutlinedButton(
                            disabled: false,
                            iconData: LineAwesomeIcons.trophy,
                            onPressed: () {
                              print('Join Challenge');
                              MyApp.navigatorKey.currentState!
                                  .pushNamed('/joinChallenge');
                            },
                            text: 'Join New Challenge',
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class OngoingChallengeCard extends StatelessWidget {
  const OngoingChallengeCard({
    super.key,
    required this.ongoingTitle,
    required this.ongoingImgPath,
    required this.ongoingPercentage,
    required this.ongonigSteps,
    required this.challengeSteps,
  });

  final String ongoingTitle;
  final String ongoingImgPath;
  final double ongoingPercentage;
  final int ongonigSteps;
  final int challengeSteps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Image.asset(
              ongoingImgPath,
              width: 100,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    ongoingTitle,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Text('$ongonigSteps/$challengeSteps steps'),
                const SizedBox(height: 10),
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width * 0.4,
                  lineHeight: 10,
                  //TODO: Percentage of challenge
                  percent: ongoingPercentage,
                  progressColor: Colors.green,
                  barRadius: const Radius.circular(16),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

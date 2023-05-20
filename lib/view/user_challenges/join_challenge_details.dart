import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';

class JoinChallengeDetails extends StatelessWidget {
  const JoinChallengeDetails({
    super.key,
    required this.challengeTitle,
    required this.challengeImgPath,
    required this.challengeDesc,
    required this.challengeSteps,
    required this.challengeVoucher,
    required this.challengeEventDuration,
  });

  final String challengeTitle;
  final String challengeImgPath;
  final String challengeDesc;
  final String challengeSteps;
  final String challengeVoucher;
  final String challengeEventDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text(challengeTitle,
                style: Theme.of(context).textTheme.bodyLarge),
            automaticallyImplyLeading: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              //?Yellow container
              color: Theme.of(context).primaryColor,
              //?Challenge info details
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 2,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Image.asset(challengeImgPath, width: 200),
                          Padding(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  challengeTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                IconAndInfo(
                                    text: 'Complete $challengeSteps steps',
                                    icon: LineAwesomeIcons.walking,
                                    color: Colors.teal),
                                IconAndInfo(
                                    text: challengeEventDuration,
                                    icon: LineAwesomeIcons.stopwatch,
                                    color: Colors.teal),
                                const SizedBox(height: 20),
                                Text(
                                  challengeDesc,
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Rewards',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                IconAndInfo(
                                    text: challengeVoucher,
                                    icon: LineAwesomeIcons.alternate_ticket,
                                    color: Colors.indigo),
                                const IconAndInfo(
                                    text: 'RM2 Family Mart Off',
                                    icon: LineAwesomeIcons.alternate_ticket,
                                    color: Colors.indigo),
                                const IconAndInfo(
                                    text: 'Buy 1 Free 1 Zus Coffee',
                                    icon: LineAwesomeIcons.alternate_ticket,
                                    color: Colors.indigo),
                                const SizedBox(height: 20),
                                const Text(
                                  'Terms and Conditions: Can only claim one reward per completed challenge.',
                                  style: TextStyle(fontSize: 10),
                                ),
                                const SizedBox(height: 20),
                                CustomOutlinedButton(
                                    onPressed: () {
                                      //TODO: ADD CHALLENGE LIST AT challenge_page.dart
                                    },
                                    iconData: LineAwesomeIcons.trophy,
                                    text: 'Join Challenge',
                                    disabled: false),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class IconAndInfo extends StatelessWidget {
  const IconAndInfo(
      {super.key, required this.color, required this.text, required this.icon});

  final Color color;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 5),
        //TODO: CHALLENGE DATE
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/model/new_challenge.dart';
import 'package:wmsm_flutter/model/users.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';

class JoinChallengeDetails extends StatelessWidget {
  JoinChallengeDetails({
    super.key,
    required this.docid,
    required this.challengeTitle,
    required this.challengeImgPath,
    required this.challengeDesc,
    required this.challengeSteps,
    required this.challengeVoucher,
    required this.challengeEventDuration,
    required this.user,
  });

  final String docid;
  final String challengeTitle;
  final String challengeImgPath;
  final String challengeDesc;
  final String challengeSteps;
  final List<String> challengeVoucher;
  final String challengeEventDuration;
  final Users user;
  FirebaseFirestore db = FirebaseFirestore.instance;
  late NewChallenge newChallenge;

  CustomOutlinedButton _outlineButton(String role) {
    if (role == 'user') {
      return CustomOutlinedButton(
          onPressed: () {
            Logger().v(role, 'user join challenge');
          },
          iconData: LineAwesomeIcons.trophy,
          text: 'Join Challenge',
          disabled: false);
    } else {
      return CustomOutlinedButton(
          onPressed: () {
            Logger().v(role, 'admin edit challenge');
            MyApp.navigatorKey.currentState!
                .pushNamed('/editChallenge', arguments: newChallenge);
          },
          iconData: LineAwesomeIcons.edit,
          text: 'Edit Challenge',
          disabled: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db.collection('challenges').doc(docid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            var challenge = snapshot.data!.data();

            newChallenge = NewChallenge(
              newChallengeDesc: challenge?['description'],
              newChallengeImgPath: challenge?['imageUrl'],
              newChallengeEventDuration: challenge?['duration'],
              newChallengeSteps: challenge?['stepGoal'],
              newChallengeTitle: challenge?['title'],
              docid: docid,
            );
            return Scaffold(
              body: Container(
                color: user.role == 'admin'
                    ? Colors.blueGrey
                    : Theme.of(context).primaryColor,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      title: Text(challenge?['title'],
                          style: Theme.of(context).textTheme.bodyLarge),
                      automaticallyImplyLeading: true,
                    ),
                    SliverToBoxAdapter(
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
                                  CachedNetworkImage(
                                    width: 200,
                                    imageUrl: challenge?['imageUrl'],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(25),
                                    child: SizedBox(
                                      height: 450,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            challenge!['title'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          IconAndInfo(
                                              text:
                                                  'Complete ${challenge['stepGoal']} steps',
                                              icon: LineAwesomeIcons.walking,
                                              color: Colors.teal),
                                          IconAndInfo(
                                              text: challenge['duration'],
                                              icon: LineAwesomeIcons.stopwatch,
                                              color: Colors.teal),
                                          const SizedBox(height: 20),
                                          Text(
                                            challenge['description'],
                                            textAlign: TextAlign.justify,
                                          ),
                                          const SizedBox(height: 20),
                                          const Text(
                                            'Rewards',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                                padding: EdgeInsets.zero,
                                                itemCount:
                                                    challengeVoucher.length,
                                                itemBuilder: (context, index) =>
                                                    FutureBuilder(
                                                        future: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "vouchers")
                                                            .doc(
                                                                challengeVoucher[
                                                                    index])
                                                            .get(),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasError) {
                                                            return const Text(
                                                                "Something went wrong");
                                                          }
                                                          if (snapshot
                                                                  .hasData &&
                                                              !snapshot.data!
                                                                  .exists) {
                                                            return const Text(
                                                                "Document does not exist");
                                                          }
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .done) {
                                                            Map<String, dynamic>
                                                                data = snapshot
                                                                        .data!
                                                                        .data()
                                                                    as Map<
                                                                        String,
                                                                        dynamic>;
                                                            return IconAndInfo(
                                                                text: data[
                                                                    'name'],
                                                                icon: LineAwesomeIcons
                                                                    .alternate_ticket,
                                                                color: Colors
                                                                    .indigo);
                                                          }
                                                          return const Text(
                                                              "loading");
                                                        })),
                                          ),
                                          const SizedBox(height: 20),
                                          const Text(
                                            'Terms and Conditions: Lorem ipsum lorem ipsum blah blah blah blah blah blah.',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const SizedBox(height: 20),
                                          _outlineButton(user.role),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
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
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}

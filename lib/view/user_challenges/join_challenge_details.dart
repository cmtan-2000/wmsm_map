import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:wmsm_flutter/main.dart';
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
                .pushNamed('/editChallenge', arguments: docid);
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
            // List<String> documentIds =
            //     snapshot.data!.docs.map((doc) => doc.id).toList();
            // var documentId = snapshot.data!.docs
            //     .firstWhere((doc) => doc.id == documentIds[0])
            //     .id;

            // var data = snapshot.data!.docs
            //     .firstWhere((doc) => doc.id == documentIds[0])
            //     .data();
            // Logger().wtf(data);

            Logger().wtf(
                'Voucher length in detail page: ${challengeVoucher.length}');

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
                                            challengeDesc,
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
                                                itemBuilder: (context, index) =>
                                                    IconAndInfo(
                                                        text: challengeVoucher[
                                                            index],
                                                        icon: LineAwesomeIcons
                                                            .alternate_ticket,
                                                        color: Colors.indigo),
                                                itemCount:
                                                    challengeVoucher.length),
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
        //TODO: CHALLENGE DATE
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}

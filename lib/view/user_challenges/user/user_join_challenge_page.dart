import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:wmsm_flutter/model/users.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/user_challenges/join_challenge_details.dart';
import 'package:wmsm_flutter/viewmodel/user_view_model.dart';

import '../../custom/widgets/awesome_snackbar.dart';
import '../../custom/widgets/custom_outlinedbutton.dart';

class UserJoinChallengePage extends StatefulWidget {
  const UserJoinChallengePage({super.key});

  @override
  State<UserJoinChallengePage> createState() => _UserJoinChallengePageState();
}

class _UserJoinChallengePageState extends State<UserJoinChallengePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String dob = '';
  String email = '';
  String fullname = '';
  String phoneNumber = '';
  String username = '';

  @override
  Widget build(BuildContext context) {
    Logger().i(db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get());
    return FutureBuilder(
      future: db
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userData = Users.fromSnapshot(snapshot.data!);
          Logger().w(userData);

          Logger().i(snapshot.data!.data());
          Logger().i(userData.role);
          return UserJoinChallengePageWidget(user: userData);
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

//* user join challenge
class UserJoinChallengePageWidget extends StatefulWidget {
  const UserJoinChallengePageWidget({super.key, required this.user});

  final Users user;

  @override
  State<UserJoinChallengePageWidget> createState() =>
      _UserJoinChallengePageWidgetState();
}

class _UserJoinChallengePageWidgetState
    extends State<UserJoinChallengePageWidget> {
  CustomOutlinedButton _outlineButton(String role, String challengeId) {
    if (role == 'user') {
      return CustomOutlinedButton(
          onPressed: () {
            showProgressDialog(context).then((value) {
              String userid = FirebaseAuth.instance.currentUser!.uid;
              FirebaseFirestore.instance
                  .collection('challenges')
                  .doc(challengeId)
                  .update({
                'challengers': FieldValue.arrayUnion([userid])
              }).then((_) {
                final snackbar = Awesome.snackbar(
                    "Challenge", "Enrolled to Challenge", ContentType.success);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackbar);
                Navigator.pop(context);
                Navigator.pop(context);
              }).catchError((error) {
                final materialBanner = Awesome.materialBanner("Challenge",
                    "Failed to Join Challenge", ContentType.failure);
                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showMaterialBanner(materialBanner);
              });
            });

            // Logger().i(challengeId);
            // TODO: add one list of challenge whenever user enrol, at challenge_page.dart
            // Logger().v(role, 'user join challenge');
          },
          iconData: LineAwesomeIcons.trophy,
          text: 'Join Challenge',
          disabled: false);
    } else {
      return CustomOutlinedButton(
          onPressed: () {
            //TODO: Redirect admin to edit challenge page
            Logger().v(role, 'admin edit challenge');
          },
          iconData: LineAwesomeIcons.edit,
          text: 'Edit Challenge',
          disabled: false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> showProgressDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) {
        // Show the dialog with CircularProgressIndicator
        return const AlertDialog(
          content: SizedBox(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    // // Delay the duration for 3 seconds
    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.pop(context); // Close the dialog after the delay
    //   Navigator.pop(context); // Close the dialog after the delay
    // });
  }

  int voucherCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text('Join Challenge',
                style: Theme.of(context).textTheme.bodyLarge),
            automaticallyImplyLeading: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height * 0.9,
              child: Consumer<UserViewModel>(
                builder: (context, userView, child) => Column(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('challenges')
                          .snapshots(),
                      builder:
                          ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          var challenges = snapshot.data!.docs;
                          var filteredDocuments = challenges;
                          // challenges
                          //     .where((doc) => !doc['challengers'].contains(
                          //         FirebaseAuth.instance.currentUser!.uid))
                          //     .toList();

                          return filteredDocuments.isEmpty
                              ? const Center(
                                  child: Text('No Data'),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: filteredDocuments.length,
                                      itemBuilder: ((context, index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0, vertical: 10),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: Card(
                                                elevation: 2,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    CachedNetworkImage(
                                                        width: 200,
                                                        imageUrl:
                                                            '${challenges[index]['imageUrl']}'),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              25),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            challenges[index]
                                                                ['title'],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall
                                                                ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          IconAndInfo(
                                                              text:
                                                                  'Complete ${challenges[index]['stepGoal']} steps',
                                                              icon:
                                                                  LineAwesomeIcons
                                                                      .walking,
                                                              color:
                                                                  Colors.teal),
                                                          IconAndInfo(
                                                              text:
                                                                  '${challenges[index]['duration']}',
                                                              icon:
                                                                  LineAwesomeIcons
                                                                      .stopwatch,
                                                              color:
                                                                  Colors.teal),
                                                          const SizedBox(
                                                              height: 20),
                                                          Text(
                                                            challenges[index]
                                                                ['description'],
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          const Text(
                                                            'Rewards',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: challenges[
                                                                        index]
                                                                    ["voucher"]
                                                                .map<Widget>(
                                                                    (voucher) =>
                                                                        IconAndInfo(
                                                                          text:
                                                                              voucher,
                                                                          icon:
                                                                              LineAwesomeIcons.alternate_ticket,
                                                                          color:
                                                                              Colors.indigo,
                                                                        ))
                                                                .toList(),
                                                          ),

                                                          const SizedBox(
                                                              height: 20),
                                                          const Text(
                                                            'Terms and Conditions: Can only claim one reward per completed challenge.',
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          challenges[index][
                                                                      'challengers']
                                                                  .contains(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                              ? Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          const Text(
                                                                              'You have joined this challenge'),
                                                                          CustomElevatedButton(
                                                                              onPressed: () {
                                                                                // showProgressDialog(context).then((value) {
                                                                                //   String userid = FirebaseAuth.instance.currentUser!.uid;
                                                                                //   FirebaseFirestore.instance
                                                                                //       .collection('challenges')
                                                                                //       .doc(challenges[index].id)
                                                                                //       .update({
                                                                                //     'challengers': FieldValue.arrayRemove([userid])
                                                                                //   }).then((_) {
                                                                                //     final snackbar = Awesome.snackbar(
                                                                                //         "Challenge", "Withdrawn from Challenge", ContentType.success);
                                                                                //     ScaffoldMessenger.of(context)
                                                                                //       ..hideCurrentSnackBar()
                                                                                //       ..showSnackBar(snackbar);
                                                                                //     Navigator.pop(context);
                                                                                //     Navigator.pop(context);
                                                                                //   }).catchError((error) {
                                                                                //     final materialBanner = Awesome.materialBanner("Challenge",
                                                                                //         "Failed to Withdraw from Challenge", ContentType.failure);
                                                                                //     ScaffoldMessenger.of(context)
                                                                                //       ..hideCurrentMaterialBanner()
                                                                                //       ..showMaterialBanner(materialBanner);
                                                                                //   });
                                                                                // });

                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (build) {
                                                                                      return AlertDialog(
                                                                                        title: const Text('Are you sure?'),
                                                                                        content: const Text('You are about to delete this challenge'),
                                                                                        actions: <Widget>[
                                                                                          TextButton(
                                                                                            onPressed: () => Navigator.of(context).pop(false),
                                                                                            child: const Text('Cancel'),
                                                                                          ),
                                                                                          TextButton(
                                                                                            onPressed: () {
                                                                                              showProgressDialog(context).then((value) {
                                                                                                String userid = FirebaseAuth.instance.currentUser!.uid;
                                                                                                FirebaseFirestore.instance.collection('challenges').doc(challenges[index].id).update({
                                                                                                  'challengers': FieldValue.arrayRemove([userid])
                                                                                                }).then((_) {
                                                                                                  final snackbar = Awesome.snackbar("Challenge", "Withdraw from Challenge", ContentType.success);
                                                                                                  ScaffoldMessenger.of(context)
                                                                                                    ..hideCurrentSnackBar()
                                                                                                    ..showSnackBar(snackbar);
                                                                                                  Navigator.pop(context);
                                                                                                  Navigator.pop(context);
                                                                                                }).catchError((error) {
                                                                                                  final materialBanner = Awesome.materialBanner("Challenge", "Failed to Withdraw from Challenge", ContentType.failure);
                                                                                                  ScaffoldMessenger.of(context)
                                                                                                    ..hideCurrentMaterialBanner()
                                                                                                    ..showMaterialBanner(materialBanner);
                                                                                                });
                                                                                              });
                                                                                            },
                                                                                            child: const Text('Delete'),
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    });
                                                                              },
                                                                              child: const Text(
                                                                                'Withdraw Challenges',
                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : _outlineButton(
                                                                  userView.user
                                                                      .role,
                                                                  challenges[
                                                                          index]
                                                                      .id,
                                                                )
                                                          // _outlineButton(user.role),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))));
                          // return const Center(child: Text('Has Data'));
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                    )
                    //!CRUD JOIN CHALLENGE LIST CARD
                    // Expanded(
                    //   child: ListView.builder(
                    //       padding:
                    //           const EdgeInsets.only(top: 10, left: 20, right: 20),
                    //       itemCount: listOfNewChallenge.length,
                    //       itemBuilder: (context, index) {
                    //         if (index >= 0 && index < listOfNewChallenge.length) {
                    //           NewChallenge challenge = listOfNewChallenge[index];

                    //           //* loop voucher length
                    //           int voucherLength =
                    //               challenge.newChallengeVoucher.length;

                    //           Logger().i(listOfNewChallenge.length);

                    //           return Card(
                    //             elevation: 2,
                    //             child: ListTile(
                    //               onTap: () {
                    //                 MyApp.navigatorKey.currentState!.push(
                    //                   MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         JoinChallengeDetails(
                    //                       challengeTitle:
                    //                           challenge.newChallengeTitle,
                    //                       challengeDesc:
                    //                           challenge.newChallengeDesc,
                    //                       challengeEventDuration:
                    //                           challenge.newChallengeEventDuration,
                    //                       challengeImgPath:
                    //                           challenge.newChallengeImgPath,

                    //                       //*Challenge steps -> int
                    //                       challengeSteps: challenge
                    //                           .newChallengeSteps
                    //                           .toString(),
                    //                       challengeVoucher:
                    //                           challenge.newChallengeVoucher[
                    //                               voucherCount % voucherLength],

                    //                       user: widget.user,
                    //                     ),
                    //                   ),
                    //                 );
                    //               },

                    //               //* image icon for challenge
                    //               leading: CircleAvatar(
                    //                 foregroundImage:
                    //                     AssetImage(challenge.newChallengeImgPath),
                    //                 backgroundColor: Colors.transparent,
                    //                 radius: 25,
                    //               ),

                    //               //* title for challenge
                    //               title: Text(challenge.newChallengeTitle),

                    //               //* duration for challenge
                    //               subtitle: Text(
                    //                   challenge.newChallengeEventDuration,
                    //                   style: const TextStyle(
                    //                       fontSize: 10, color: Colors.teal)),

                    //               //!TEST THIS UI
                    //               trailing: const Icon(Icons.arrow_forward_ios),
                    //             ),
                    //           );
                    //         } else {
                    //           return Container();
                    //         }
                    //       }),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:wmsm_flutter/api/localnotification_api.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/model/new_challenge.dart';
import 'package:wmsm_flutter/model/users.dart';
import 'package:wmsm_flutter/view/user_challenges/join_challenge_details.dart';

class AdminJoinChallengePage extends StatefulWidget {
  const AdminJoinChallengePage({super.key, required this.user});

  final Users user;

  @override
  State<AdminJoinChallengePage> createState() => _AdminJoinChallengePageState();
}

class _AdminJoinChallengePageState extends State<AdminJoinChallengePage> {
  int voucherCount = 0;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String id = '';
  List<NewChallenge> listOfNewChallenge = [];

  @override
  initState() {
    super.initState();
    LocalNotification.init();
    listenNotifications();
  }

  //*the moment click notification, it will listen here and direct to the page
  void listenNotifications() =>
      LocalNotification.onNotifications.stream.listen(notificationDirect);

  void notificationDirect(String? payload) {
    Logger().wtf("Check Payload: $payload");
    if (payload != null) {
      MyApp.navigatorKey.currentState!.pushNamed('/userjoinChallenge');
      LocalNotification.clearPayload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db.collection("challenges").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> documentIds =
                snapshot.data!.docs.map((doc) => doc.id).toList();
            Logger().i(documentIds.length);

            if (documentIds.isEmpty) {
              return Scaffold(
                body: const Center(
                  child: Text('No challenges available :(',
                      style: TextStyle(color: Colors.blueGrey)),
                ),
                floatingActionButton: FloatingActionButton(
                  //* direct to admin add challenge page
                  onPressed: () {
                    MyApp.navigatorKey.currentState!.pushNamed('/addChallenge');
                  },
                  backgroundColor: Colors.white,
                  tooltip: 'Add new challenge',
                  child:
                      const Icon(LineAwesomeIcons.plus, color: Colors.blueGrey),
                ),
              );
            } else {
              return Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      title: Text('Manage Challenge',
                          style: Theme.of(context).textTheme.bodyLarge),
                      automaticallyImplyLeading: false,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.blueGrey,
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  itemCount: documentIds.length,
                                  itemBuilder: (context, index) {
                                    List<dynamic> voucherList =
                                        snapshot.data!.docs[index]['voucher'];
                                    List<String> newChallengeVoucher =
                                        voucherList
                                            .map(
                                                (voucher) => voucher.toString())
                                            .toList();

                                    NewChallenge challenge = NewChallenge(
                                      //get the data from firestore and store in a list
                                      newChallengeTitle:
                                          snapshot.data!.docs[index]['title'],
                                      newChallengeDesc: snapshot
                                          .data!.docs[index]['description'],
                                      newChallengeEventDuration: snapshot
                                          .data!.docs[index]['duration'],
                                      newChallengeImgPath: snapshot
                                          .data!.docs[index]['imageUrl'],
                                      newChallengeSteps: snapshot
                                          .data!.docs[index]['stepGoal'],
                                      newChallengeVoucher: newChallengeVoucher,
                                    );

                                    listOfNewChallenge.add(challenge);

                                    //* get the document id
                                    String id = documentIds[index];

                                    Logger().wtf(index);
                                    Logger().i(challenge.newChallengeImgPath);
                                    Logger().i(challenge);

                                    //* loop voucher length
                                    int voucherLength =
                                        challenge.newChallengeVoucher.length;

                                    return Dismissible(
                                      //*cannot use the same key for dismissible, must be unique for each
                                      key: UniqueKey(),
                                      background: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          color: Colors.red[400],
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: const Icon(
                                              LineAwesomeIcons.trash,
                                              color: Colors.white),
                                        ),
                                      ),
                                      //*warn the admin before deleting a challenge
                                      confirmDismiss: (direction) {
                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Are you sure?'),
                                                content: const Text(
                                                    'You are about to delete this challenge'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: const Text('Delete'),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      onDismissed: (direction) {
                                        //* Remove the challenge from list
                                        db
                                            .collection('challenges')
                                            .doc(id)
                                            .delete()
                                            .then((value) => Logger().i(
                                                'Challenge deleted successfully'))
                                            .catchError((error) => Logger().e(
                                                'Failed to delete challenge: $error'));

                                        setState(() {
                                          listOfNewChallenge.removeAt(index);
                                        });

                                        direction == DismissDirection.endToStart
                                            ? ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Deleted successfully'),
                                                duration: Duration(seconds: 1),
                                              ))
                                            : null;
                                      },
                                      child: Card(
                                        elevation: 2,
                                        child: ListTile(
                                          onTap: () {
                                            MyApp.navigatorKey.currentState!
                                                .push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    JoinChallengeDetails(
                                                  docid: snapshot
                                                      .data!.docs[index].id,
                                                  challengeTitle: challenge
                                                      .newChallengeTitle,
                                                  challengeDesc: challenge
                                                      .newChallengeDesc,
                                                  challengeEventDuration: challenge
                                                      .newChallengeEventDuration,
                                                  challengeImgPath: challenge
                                                      .newChallengeImgPath,

                                                  //*Challenge steps -> int
                                                  challengeSteps: challenge
                                                      .newChallengeSteps
                                                      .toString(),
                                                  challengeVoucher: challenge
                                                          .newChallengeVoucher[
                                                      voucherCount %
                                                          voucherLength],

                                                  user: widget.user,
                                                ),
                                              ),
                                            );
                                          },

                                          //* image icon for challenge
                                          leading: CircleAvatar(
                                            foregroundImage:
                                                CachedNetworkImageProvider(
                                                    challenge
                                                        .newChallengeImgPath),
                                            backgroundColor: Colors.transparent,
                                            radius: 25,
                                          ),

                                          //* title for challenge
                                          title:
                                              Text(challenge.newChallengeTitle),

                                          //* duration for challenge
                                          subtitle: Text(
                                              challenge
                                                  .newChallengeEventDuration,
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.teal)),

                                          trailing: const Icon(
                                              Icons.arrow_forward_ios),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  //* direct to admin add challenge page
                  onPressed: () {
                    LocalNotification.showNotification(
                      title: 'New Challenge Released',
                      body: 'Challenge is released, check it out now!',
                      payload: 'user_challenge',
                    );
                    //MyApp.navigatorKey.currentState!.pushNamed('/addChallenge');
                  },
                  backgroundColor: Colors.white,
                  tooltip: 'Add new challenge',
                  child: const Icon(
                    LineAwesomeIcons.plus,
                    color: Colors.blueGrey,
                  ),
                ),
              );
            }
          } else if (snapshot.hasError) {
            const Center(child: Text('Error 404'));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

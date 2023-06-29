// This is challenge page

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_button.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';
import 'package:wmsm_flutter/view/user_challenges/admin/admin_manage_challenge_page.dart';
import 'package:wmsm_flutter/viewmodel/health_conn_view/health_conn_view_model.dart';

import '../../model/users.dart';
import '../../viewmodel/shared/shared_pref.dart';
import '../../viewmodel/voucher/voucher_view_model.dart';
import '../custom/widgets/awesome_snackbar.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  Users user = Users(
      dateOfBirth: '',
      email: '',
      fullname: '',
      phoneNumber: '',
      username: '',
      role: '');

  // NewChallenge challenge = NewChallenge(
  //     newChallengeDesc: '',
  //     newChallengeEventDuration: '',
  //     newChallengeImgPath: '',
  //     newChallengeSteps: 0,
  //     newChallengeTitle: '',
  //     newChallengeVoucher: []);

  SharedPref sharedPref = SharedPref();

  @override
  initState() {
    super.initState();
    initialGetUserSavedData();
    // initialGetChallengeSavedData();
  }

  void initialGetUserSavedData() async {
    Users response = Users.fromJson(await sharedPref.read("user"));
    setState(() {
      user = Users(
          dateOfBirth: response.dateOfBirth,
          email: response.email,
          fullname: response.fullname,
          phoneNumber: response.phoneNumber,
          role: response.role,
          username: response.username);
    });
  }

  // void initialGetChallengeSavedData() async {
  //   NewChallenge response =
  //       NewChallenge.fromJson(await sharedPref.read("challenges"));
  //   setState(() {
  //     challenge = NewChallenge(
  //         newChallengeDesc: response.newChallengeDesc,
  //         newChallengeEventDuration: response.newChallengeEventDuration,
  //         newChallengeImgPath: response.newChallengeImgPath,
  //         newChallengeSteps: response.newChallengeSteps,
  //         newChallengeTitle: response.newChallengeTitle,
  //         newChallengeVoucher: response.newChallengeVoucher);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return user.role == 'admin'
        //*if is admin, directly head to the list of challenge
        ? AdminJoinChallengePage(
            user: user,
          )
        //*else if is user, head to where they view their challenge progress
        : user.role == 'user'
            ? const UserChallengePage()
            : const Center(child: CircularProgressIndicator()); // Admin Page
  }
}

class UserChallengePage extends StatelessWidget {
  const UserChallengePage({
    super.key,
  });

  String convertFormatDate(String date) {
    List<String> startDateParts = date.split('/');
// Convert the start date parts into a valid format (YYYY-MM-DD)
    String validStartDateString =
        '${startDateParts[2].padLeft(4, '0')}-${startDateParts[1].padLeft(2, '0')}-${startDateParts[0].padLeft(2, '0')}';

// Parse the valid start date string into a DateTime object
    DateTime startDate = DateTime.parse(validStartDateString);
    return startDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text('Challenge',
                  style: Theme.of(context).textTheme.bodyLarge),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    icon: const Icon(LineAwesomeIcons.alternate_ticket),
                    onPressed: () {
                      MyApp.navigatorKey.currentState!.pushNamed('/voucher');
                  }),
              ],
            ),
            SliverToBoxAdapter(
                child: Column(
              children: [
                const SizedBox(height: 20),
                Card(
                  elevation: 2,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20.0),
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
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('challenges')
                                .where('challengers',
                                    arrayContains:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                Logger().i(snapshot.data!.docs.length);
                                return snapshot.data!.docs.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          DocumentSnapshot ds =
                                              snapshot.data!.docs[index];
                                          List<String> datePart =
                                              ds['duration'].split(' - ');
                                          String startDateString =
                                              convertFormatDate(datePart[0]);
                                          String endDateString =
                                              convertFormatDate(datePart[1]);

                                          double percentage = 0.0;

                                          return FutureBuilder<int>(
                                            future: Provider.of<
                                                        HealthConnViewModel>(
                                                    context,
                                                    listen: false)
                                                .getInternalStep(
                                                    startDateString,
                                                    endDateString),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<int> snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (snapshot.hasError) {
                                                return const Center(
                                                    child: Text('Error'));
                                              } else {
                                                percentage = (snapshot.data! /
                                                        ds['stepGoal']) *
                                                    100;
                                                String formattedPercentage =
                                                    percentage
                                                        .toStringAsFixed(2);
                                                percentage = double.parse(
                                                        formattedPercentage) /
                                                    100;
                                                percentage =
                                                    percentage.clamp(0.0, 1.0);
                                                Logger().i(percentage);

                                                return OngoingChallengeCard(
                                                  id: ds.id,
                                                  ongoingTitle: ds['title'],
                                                  ongoingImgPath:
                                                      'assets/images/challenge1.png',
                                                  ongoingPercentage: percentage,
                                                  ongoingSteps: snapshot.data!,
                                                  challengeSteps:
                                                      ds['stepGoal'],
                                                );
                                              }
                                            },
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: Text('No Challenge Join'),
                                      );
                              } else if (snapshot.hasError) {
                                return const Center(child: Text('Error larh'));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomOutlinedButton(
                            disabled: false,
                            iconData: LineAwesomeIcons.trophy,
                            onPressed: () {
                              Logger().i('Join Challenge');
                              MyApp.navigatorKey.currentState!
                                  .pushNamed('/userjoinChallenge');
                            },
                            text: 'Join New Challenge',
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class OngoingChallengeCard extends StatefulWidget {
  const OngoingChallengeCard({
    super.key,
    required this.id,
    required this.ongoingTitle,
    required this.ongoingImgPath,
    required this.ongoingPercentage,
    required this.ongoingSteps,
    required this.challengeSteps,
  });
  final String id;
  final String ongoingTitle;
  final String ongoingImgPath;
  final double ongoingPercentage;
  final int ongoingSteps;
  final int challengeSteps;

  @override
  State<OngoingChallengeCard> createState() => _OngoingChallengeCardState();
}

class _OngoingChallengeCardState extends State<OngoingChallengeCard> {
  VoucherViewModel vvm = VoucherViewModel();
  var checkTicketAvailable = true;
  var checkTicketClaimed = true;
  List<String> listVoucher = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAvailable();
    checkClaimed();
  }

  void checkAvailable() async {
    var result = await vvm.checkChallengesQuantityVoucher(widget.id);
    setState(() {
      checkTicketAvailable = result;
    });
  }

  void checkClaimed() async {
    listVoucher = await vvm.getVoucherIdByChallengeId(widget.id);
    var result = await vvm.checkVoucher(
        FirebaseAuth.instance.currentUser!.uid, listVoucher);
        Logger().wtf(result.toString());
    setState(() {
      checkTicketClaimed = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset(
                widget.ongoingImgPath,
                width: 100,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      widget.ongoingTitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text('${widget.ongoingSteps}/${widget.challengeSteps} steps'),
                  const SizedBox(height: 10),
                  widget.ongoingPercentage == 1
                      ? checkTicketClaimed
                          // ? checkTicketAvailable
                          //   ? CustomElevatedButton(onPressed: (){
                          //       Logger().i(listVoucher);
                          //         vvm.getAvailableVoucher(listVoucher)
                          //             .then((value) =>
                          //                 ScaffoldMessenger.of(
                          //                         context)
                          //                     .showSnackBar(
                          //                   Awesome.snackbar(
                          //                     'Congratulations!',
                          //                     'You have claim the ticket id: $value !',
                          //                     ContentType.success,
                          //                   ),
                          //                 ));
                          //         }, child: const Text("Claim Reward"))
                          //     :
                          //       CustomOutlinedButton(
                          //           onPressed: () {},
                          //           text: "Voucher Out of Stock",
                          //           disabled: true,
                          //           iconData: null,
                          //         )
                          ? CustomOutlinedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  Awesome.snackbar(
                                    'Sorry!',
                                    'You have already claimed the reward!',
                                    ContentType.warning,
                                  ),
                                );
                              },
                              iconData: null,
                              text: "Claimed",
                              disabled: true)

                          : checkTicketAvailable
                            ? CustomElevatedButton(onPressed: (){
                                  vvm.getAvailableVoucher(listVoucher)
                                      .then((value) =>
                                      // Perform Insertion to UserVoucher
                                        vvm.insertUserVoucher(value)
                                       ).then((value) =>
                                        // Perform Update to Voucher
                                        vvm.updateVoucher(value)
                                       ).then((value) => ScaffoldMessenger.of(
                                                context)
                                            .showSnackBar(
                                          Awesome.snackbar(
                                            'Congratulations!',
                                            'You have claim the ticket id: $value !',
                                            ContentType.success,
                                          ),
                                        )).then((value) {
                                          checkClaimed();
                                          checkAvailable();
                                          setState(() {
                                            
                                          });
                                        });

                                  }, child: const Text("Claim Reward"))
                              :CustomOutlinedButton(
                                    onPressed: () {},
                                    text: "Voucher Out of Stock",
                                    disabled: true,
                                    iconData: null,
                                  )
                          
                      : LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width * 0.4,
                          lineHeight: 10,
                          //TODO: Percentage of challenge
                          percent: widget.ongoingPercentage,
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
      ),
    );
  }
}

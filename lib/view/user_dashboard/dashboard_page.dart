// ignore_for_file: non_constant_identifier_names
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/model/users.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/user_dashboard/widgets/barchart.dart';
import 'package:wmsm_flutter/viewmodel/shared/shared_pref.dart';
import 'package:wmsm_flutter/viewmodel/user_view_model.dart';

import '../../viewmodel/health_conn_view/health_conn_view_model.dart';
import '../custom/widgets/awesome_snackbar.dart';
import '../custom/widgets/draggleline.dart';
import 'admin_dashboard_page.dart';

//* The dashboard page to determine user dashboard or admin dashboard
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Users user = Users(
      dateOfBirth: '',
      email: '',
      fullname: '',
      phoneNumber: '',
      username: '',
      role: '');
  SharedPref sharedPref = SharedPref();
  TextEditingController goalController = TextEditingController();
  UserViewModel userViewModel = UserViewModel();
  @override
  initState() {
    super.initState();
    initialGetSavedData();
    Future.delayed(const Duration(seconds: 1), () async {
      Provider.of<HealthConnViewModel>(context, listen: false).getSteps();
      Provider.of<HealthConnViewModel>(context, listen: false).getWeeklyStep();
      Provider.of<HealthConnViewModel>(context, listen: false).getMonthlyStep();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // userViewModel.disposeAll;
    Logger().v('dispose', 'dashboard');
  }

  


  void initialGetSavedData() async {
    // Users response = Users.fromJson(await sharedPref.read("user"));

    final response = Provider.of<UserViewModel>(context, listen: false).user;

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

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userView, child) {
      return userView.user.role == 'admin'
          ? AdminDashboard()
          : userView.user.role == 'user'
              ? UserDashboard(user: userView.user)
              : const Center(child: CircularProgressIndicator());
    });
  }
}

class UserDashboard extends StatefulWidget {
   const UserDashboard({
    super.key,
    required this.user,
  });

  final Users user;

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  UserViewModel userViewModel = UserViewModel();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Home', style: Theme.of(context).textTheme.bodyLarge),
              automaticallyImplyLeading: false,
              actions: [
                GestureDetector(
                  onTap: () {
                    MyApp.navigatorKey.currentState!.pushNamed('/notification');
                  },
                  child: const Badge(
                    label: Text('12'),
                    //TODO: Flutter riverpod change
                    isLabelVisible: true,
                    child: Icon(LineAwesomeIcons.bell),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  //?Welcome back card
                  Card(
                    elevation: 2,
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: [
                            Text(
                              'Welcome back\n${widget.user.fullname}!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            //?Step count card
                            Card(
                              elevation: 2,
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text('Daily Step Count:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall),
                                    ),
                                    const SizedBox(height: 20),
                                    Consumer<HealthConnViewModel>(
                                      builder: (context, health, child) =>
                                          health.authorize
                                              ? health.step.isNotEmpty
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 200,
                                                          child: Column(
                                                            children: [
                                                              //TODO: Add step count
                                                              Consumer<
                                                                  HealthConnViewModel>(
                                                                builder: (context,
                                                                        health,
                                                                        child) =>
                                                                    health.step
                                                                            .isEmpty
                                                                        ? const CircularProgressIndicator()
                                                                        : Text(
                                                                            health.step['step'].toString(),
                                                                            style:
                                                                                const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                                                                          ),
                                                              ),
                                                              const Text(
                                                                  'steps',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 138,
                                                          child: Image.asset(
                                                            'assets/images/walking.png',
                                                          ),
                                                          
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            //TODO: Add step count
                                                            SizedBox(
                                                              width: 138,
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/error2.png',
                                                              ),
                                                            ),
                                                            const Text(
                                                              'Not connected to Google Fit',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .red),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                              : const CircularProgressIndicator()
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  //?Yellow container

                  Container(
                    color: Theme.of(context).primaryColor,
                    width: double.infinity,
                    child: Column(
                      children: [
                        // StreamBuilder<int>(
                        //   stream: Provider.of<UserViewModel>(context)
                        //       .stepGoalStream,
                        //   builder: (context, snapshot) {
                        //     if (snapshot.hasData) {
                        //       return Column(
                        //         children: [
                        //           const SizedBox(height: 20),
                        //           Text(
                        //             'Your Goal',
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyLarge
                        //                 ?.copyWith(
                        //                     fontWeight: FontWeight.bold),
                        //           ),
                        //           const SizedBox(height: 20),
                        //           Text(
                        //             'Your goal is ${snapshot.data} steps',
                        //             style: Theme.of(context)
                        //                 .textTheme
                        //                 .bodyMedium
                        //                 ?.copyWith(
                        //                     fontWeight: FontWeight.bold),
                        //           ),
                        //           const SizedBox(height: 20),
                        //         ],
                        //       );
                        //     } else {
                        //       return Container();
                        //     }
                        //   },
                        // ),
                        // Consumer<UserViewModel>(
                        //   builder: (context, user, child) => Text("${user.goal}")
                        // ),
                        const SizedBox(height: 20),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                          builder: ((BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if(snapshot.hasData){
                              var userData = snapshot.data!.data() as Map<String, dynamic>;
                              // if goal attribute exist
                              if (userData.containsKey('goal')) {
                                  // 'goal' attribute exists
                                  if (userData['goal'] != null &&
                                      userData['goal'].isNotEmpty) {
                                    // 'goal' attribute is not empty
                                    // return Text(
                                    //     'Has user data goal: ${userData['goal']}');
                                    return DashboardCardWidget(
                                      title: 'Goals',
                                      imgPath: 'assets/images/goal.png',
                                      infoCard: 'This is your goal Set: ${userData['goal']} left to Go!',
                                      onPressed: () {
                                        showDialog(context: context, builder: (context) {
                                          var goalDialog = GoalDialog(context);
                                          return goalDialog;
                                        });
                                      },
                                    );
                                  } else {
                                    // 'goal' attribute is empty
                                    return DashboardCardWidget(
                                      title: 'Goals',
                                      imgPath: 'assets/images/goal.png',
                                      infoCard:
                                          'your Goal is Empty',
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              var goalDialog =
                                                  GoalDialog(context);
                                              return goalDialog;
                                            });
                                      },
                                    );
                                  }
                                } else {
                                  // 'goal' attribute does not exist
                                  return DashboardCardWidget(
                                      title: 'Goals',
                                      imgPath: 'assets/images/goal.png',
                                      infoCard:
                                          'No goal set',
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              var goalDialog =
                                                  GoalDialog(context);
                                              return goalDialog;
                                            });
                                      },
                                    );;
                                }
                            }
                            return Container();
                          }))
                        ,
                        
                        const SizedBox(height: 20),
                        //?Challenges card
                        DashboardCardWidget(
                          title: 'Challenges',
                          imgPath: 'assets/images/challenge.png',
                          infoCard: 'Get rewarded by joining challenge!',
                          onPressed: () {
                            MyApp.navigatorKey.currentState!
                                .pushNamed('/challengePage');
                          },
                        ),
                        const SizedBox(height: 20),
                        DashboardCardWidget(
                          title: 'Health Article',
                          imgPath: 'assets/images/newspaper.png',
                          infoCard: 'Health article is out now!',
                          onPressed: () {
                            MyApp.navigatorKey.currentState!
                                .pushNamed('/articlePage');
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const BarChart(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AlertDialog GoalDialog(BuildContext context){
    TextEditingController goalController = TextEditingController();
    return AlertDialog(
      title: const Text('Set Goal'),
      content: TextField(
        controller: goalController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Enter your goal',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
              'goal': goalController.text,
            }, SetOptions(merge: true)).then((value){

                final snackbar = Awesome.snackbar("Goal", "Goal ${goalController.text} set", ContentType.success);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackbar);
                Navigator.of(context).pop();
            });
          },
          child: const Text('Save'),
        ),
        
        TextButton(
          onPressed: () {
            // Close the dialog without saving
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

class DashboardCardWidget extends StatelessWidget {
  const DashboardCardWidget({
    super.key,
    required this.imgPath,
    required this.title,
    required this.infoCard,
    required this.onPressed,
  });

  final String imgPath;
  final String title;
  final String infoCard;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imgPath,
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                infoCard,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomElevatedButton(
                            //?Navigate to the challenge page / article page
                            onPressed: onPressed,
                            child: const Text('Join'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

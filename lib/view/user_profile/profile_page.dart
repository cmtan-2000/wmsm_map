//This is profile page
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/model/users.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/cover_profile.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/profile_menu_widget.dart';
import 'package:wmsm_flutter/viewmodel/health_conn_view/health_conn_view_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String dob = '';
  String email = '';
  String fullname = '';
  String phoneNumber = '';
  String username = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: db
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userData = Users.fromSnapshot(snapshot.data!);

            Logger().i(snapshot.data!.data());
            Logger().i(userData.email);
            return CoverContent(
              content: ProfilePageWidget(user: userData),
              title: 'Profile',
              users: userData,
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key, required this.user});

  final Users user;

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late String bmiResult;
  late Color bmitextColor;
  FirebaseFirestore db = FirebaseFirestore.instance;
  double currentBMIValue = 0;
  String phoneNumber = '', username = '', fullname = '', email = '', dob = '';

  Widget getRadialGauge() {
    if (currentBMIValue == 0) {
      bmiResult = 'Please enter your info to calculate your BMI';
      bmitextColor = Colors.grey;
    } else if (currentBMIValue > 0 && currentBMIValue < 18.5) {
      bmiResult = 'Underweight';
      bmitextColor = Colors.blue;
    } else if (currentBMIValue >= 18.5 && currentBMIValue < 25) {
      bmiResult = 'Normal';
      bmitextColor = Colors.green;
    } else if (currentBMIValue >= 25 && currentBMIValue < 30) {
      bmiResult = 'Overweight';
      bmitextColor = Colors.yellow;
    } else if (currentBMIValue >= 30 && currentBMIValue < 35) {
      bmiResult = 'Obese';
      bmitextColor = Colors.orange;
    } else {
      bmiResult = 'Extremely Obese';
      bmitextColor = Colors.red;
    }

    return SfRadialGauge(
      title: const GaugeTitle(
          text: 'BMI Result',
          textStyle: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.black)),
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 36,
          ranges: <GaugeRange>[
            //*Underweight
            GaugeRange(
                startValue: 0,
                endValue: 18.5,
                color: Colors.blue[200],
                startWidth: 10,
                endWidth: 10),
            //*Normal
            GaugeRange(
                startValue: 18.5,
                endValue: 24.99,
                color: Colors.green,
                startWidth: 10,
                endWidth: 10),
            //*Overweight
            GaugeRange(
                startValue: 24.99,
                endValue: 29.99,
                color: Colors.yellow[600],
                startWidth: 10,
                endWidth: 10),
            //*Obese
            GaugeRange(
                startValue: 29.99,
                endValue: 34.99,
                color: Colors.orange[600],
                startWidth: 10,
                endWidth: 10),
            //*Extremely obese
            GaugeRange(
                startValue: 34.99,
                endValue: 36,
                color: Colors.red,
                startWidth: 10,
                endWidth: 10),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              enableAnimation: true,
              value: currentBMIValue,
              needleLength: 0.3,
              //! take note
              onValueChanged: (double newBMI) {
                setState(() {
                  print("onvaluechange: $currentBMIValue");
                  currentBMIValue = newBMI;
                });
              },
            )
          ], //*needle pointer for gauge
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Text(currentBMIValue.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                angle: 90,
                positionFactor: 0.8),
          ],
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Logger().i('user data: ${widget.user.username}');
    Logger().v('user bmi: ${widget.user.bmi}');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (widget.user.role == "user") {
                  username = widget.user.username;
                  phoneNumber = widget.user.phoneNumber;

                  if (widget.user.bmi != null) {
                    currentBMIValue = widget.user.bmi!.toDouble();
                  } else {
                    currentBMIValue = 0;
                  }

                  return Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 0.5,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 180,
                                width: 180,
                                child: getRadialGauge(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 40.0, right: 40.0),
                                child: Text(
                                  bmiResult,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: bmitextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //*To display BMI result
                      ProfileMenuWidget(
                        titleText: 'BMI info',
                        icon: LineAwesomeIcons.weight,
                        color: Colors.black,
                        onTap: () {
                          MyApp.navigatorKey.currentState!
                              .pushNamed('/bmiInfo', arguments: widget.user);
                        },
                        endIcon: true,
                        role: widget.user.role,
                      ),

                      ProfileMenuWidget(
                        //titleText: user.username,
                        titleText: username,
                        icon: LineAwesomeIcons.user,
                        color: Colors.black,
                        onTap: () {
                          MyApp.navigatorKey.currentState!.pushNamed(
                              '/editUserName',
                              arguments: widget.user);
                        },
                        endIcon: true,
                        role: widget.user.role,
                      ),
                      ProfileMenuWidget(
                        //titleText: user.phoneNumber,
                        titleText: '+60 $phoneNumber',

                        icon: LineAwesomeIcons.phone,
                        color: Colors.black,
                        onTap: () {
                          MyApp.navigatorKey.currentState!.pushNamed(
                              '/editPhoneNo',
                              arguments: widget.user);
                        },
                        endIcon: true,
                        role: widget.user.role,
                      ),
                      Consumer<HealthConnViewModel>(
                        builder: (context, health, child) => health.authorize
                            ? ProfileMenuWidget(
                                titleText: 'Sync App',
                                icon: LineAwesomeIcons.shoe_prints,
                                color: Colors.green,
                                endIcon: true,
                                role: widget.user.role)
                            : ProfileMenuWidget(
                                titleText: 'No Sync App',
                                icon: LineAwesomeIcons.shoe_prints,
                                color: Colors.red,
                                //TODO: sync google fit
                                onTap: () {},
                                endIcon: true,
                                role: widget.user.role,
                              ),
                      ),
                      ProfileMenuWidget(
                        titleText: 'Password',
                        icon: LineAwesomeIcons.lock,
                        color: Colors.black,
                        onTap: () {
                          MyApp.navigatorKey.currentState!
                              .pushNamed('/editPwd', arguments: widget.user);
                        },
                        endIcon: true,
                        role: widget.user.role,
                      ),
                      ProfileMenuWidget(
                        titleText: widget.user.email,
                        icon: LineAwesomeIcons.envelope,
                        color: Colors.black,
                        endIcon: false,
                        role: widget.user.role,
                      ),
                      ProfileMenuWidget(
                        titleText: widget.user.dateOfBirth,
                        icon: LineAwesomeIcons.calendar,
                        color: Colors.black,
                        endIcon: false,
                        role: widget.user.role,
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 20),
                      ProfileMenuWidget(
                        titleText: 'Sign Out',
                        icon: LineAwesomeIcons.alternate_sign_out,
                        color: Colors.black,
                        endIcon: false,
                        role: widget.user.role,
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          MyApp.navigatorKey.currentState!.pushNamed('/');
                        },
                      ),
                    ],
                  );
                } else {
                  phoneNumber = widget.user.phoneNumber;
                  email = widget.user.email;

                  return Column(
                    children: [
                      ProfileMenuWidget(
                        titleText: email,
                        icon: LineAwesomeIcons.envelope,
                        color: Colors.black,
                        endIcon: false,
                        role: widget.user.role,
                      ),
                      ProfileMenuWidget(
                        titleText: 'Password',
                        icon: LineAwesomeIcons.lock,
                        color: Colors.black,
                        onTap: () {
                          //TODO: Change password
                          MyApp.navigatorKey.currentState!
                              .pushNamed('/editPwd', arguments: widget.user);
                        },
                        endIcon: true,
                        role: widget.user.role,
                      ),
                      ProfileMenuWidget(
                        titleText: '+60 $phoneNumber',
                        icon: LineAwesomeIcons.phone,
                        color: Colors.black,
                        onTap: () {
                          //!Change PHONE NUMBER
                          MyApp.navigatorKey.currentState!.pushNamed(
                              '/editPhoneNo',
                              arguments: widget.user);
                        },
                        endIcon: true,
                        role: widget.user.role,
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 20),
                      ProfileMenuWidget(
                        titleText: 'Sign Out',
                        icon: LineAwesomeIcons.alternate_sign_out,
                        color: Colors.black,
                        endIcon: false,
                        role: widget.user.role,
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          MyApp.navigatorKey.currentState!.pushNamed('/');
                        },
                      ),
                    ],
                  );
                }
              },
            )),
      ),
    );
  }
}

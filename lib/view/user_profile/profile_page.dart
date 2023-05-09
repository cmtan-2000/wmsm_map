//This is profile page
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/model/users.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/cover_profile.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/profile_menu_widget.dart';

Users users = Users(
    dateOfBirth: '', email: '', fullname: '', phoneNumber: '', username: '');

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String dob, email, fullname, phoneNumber, username;

    return StreamBuilder(
        stream: db
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            dob = snapshot.data!.data()!['dateOfBirth'];
            email = snapshot.data!.data()!['email'];
            fullname = snapshot.data!.data()!['fullname'];
            phoneNumber = snapshot.data!.data()!['phoneNumber'];
            username = snapshot.data!.data()!['username'];
            print('dob: $dob');
            print('fullname: $fullname');
            print('username: $username');
            print('phoneNumber: $phoneNumber');

            users = Users(
                dateOfBirth: dob,
                email: email,
                fullname: fullname,
                phoneNumber: phoneNumber,
                username: username);

            return CoverContent(
              content: const ProfilePageWidget(),
              title: 'Profile',
              users: users,
            );
          }
          return const Center(child: Text('Error'));
        });
  }
}

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late String bmiResult;
  late Color bmitextColor;
  FirebaseFirestore db = FirebaseFirestore.instance;
  double currentBMIValue = 0;
  String phoneNumber = users.phoneNumber, username = users.username;

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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
              stream: db
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  username = snapshot.data!['username'];
                  phoneNumber = snapshot.data!['phoneNumber'];

                  Map<String, dynamic> checkBMiKey =
                      snapshot.data!.data() as Map<String, dynamic>;
                  if (checkBMiKey.containsKey('bmi')) {
                    currentBMIValue = snapshot.data!['bmi'].toDouble();
                    print(currentBMIValue);
                  } else {
                    currentBMIValue = 0;
                    print(currentBMIValue);
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
                              .pushNamed('/bmiInfo');
                        },
                        endIcon: true,
                      ),

                      ProfileMenuWidget(
                        //titleText: user.username,
                        titleText: username,
                        icon: LineAwesomeIcons.user,
                        color: Colors.black,
                        onTap: () {
                          MyApp.navigatorKey.currentState!
                              .pushNamed('/editUserName');
                        },
                        endIcon: true,
                      ),
                      ProfileMenuWidget(
                        //titleText: user.phoneNumber,
                        titleText: '+60 $phoneNumber',

                        icon: LineAwesomeIcons.phone,
                        color: Colors.black,
                        onTap: () {
                          MyApp.navigatorKey.currentState!
                              .pushNamed('/editPhoneNo');
                        },
                        endIcon: true,
                      ),
                      ProfileMenuWidget(
                        titleText: 'No Sync App',
                        icon: LineAwesomeIcons.shoe_prints,
                        color: Colors.red,
                        //TODO: sync google fit
                        onTap: () {},
                        endIcon: true,
                      ),
                      ProfileMenuWidget(
                        titleText: 'Password',
                        icon: LineAwesomeIcons.lock,
                        color: Colors.black,
                        onTap: () {
                          MyApp.navigatorKey.currentState!
                              .pushNamed('/editPwd');
                        },
                        endIcon: true,
                      ),
                      ProfileMenuWidget(
                        titleText: users.email,
                        icon: LineAwesomeIcons.envelope,
                        color: Colors.black,
                        endIcon: false,
                      ),
                      ProfileMenuWidget(
                        titleText: users.dateOfBirth,
                        icon: LineAwesomeIcons.calendar,
                        color: Colors.black,
                        endIcon: false,
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 20),
                      ProfileMenuWidget(
                        titleText: 'Sign Out',
                        icon: LineAwesomeIcons.alternate_sign_out,
                        color: Colors.black,
                        endIcon: false,
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          MyApp.navigatorKey.currentState!.pushNamed('/');
                        },
                      ),
                    ],
                  );
                }
                return const Text("Test");
              }),
        ),
      ),
    );
  }
}

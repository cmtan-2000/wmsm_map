//This is profile page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/model/users.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/cover_profile.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/profile_menu_widget.dart';

//*converting the date to string
DateTime dob = DateTime(2005, 01, 01);

//*Testing with dummy data (shud use 'get, set')
Users user = Users(
  fullname: 'Siew Yu Xuan',
  username: 'swx000',
  email: 'eunicelim1520@gmail.com',
  //password: '******',
  phoneNumber: '011-1234567',
  //*convert the date format to string
  dateOfBirth: DateFormat('MMM d, yyyy').format(dob),
  height: 100,
  weight: 50,
  bmi: 17.0,
);

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CoverContent(
      content: const ProfilePageWidget(),
      title: 'Profile',
      user: user,
    );
  }
}

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  double _currentBMIValue = user.bmi!;

  late String bmiResult;
  late Color bmitextColor;

  Widget getRadialGauge() {
    if (_currentBMIValue < 18.5) {
      bmiResult = 'Underweight';
      bmitextColor = Colors.blue;
    } else if (_currentBMIValue >= 18.5 && _currentBMIValue < 25) {
      bmiResult = 'Normal';
      bmitextColor = Colors.green;
    } else if (_currentBMIValue >= 25 && _currentBMIValue < 30) {
      bmiResult = 'Overweight';
      bmitextColor = Colors.yellow;
    } else if (_currentBMIValue >= 30 && _currentBMIValue < 35) {
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
              value: _currentBMIValue,
              needleLength: 0.3,
              //! take note
              onValueChanged: (double newBMI) {
                setState(() {
                  _currentBMIValue = newBMI;
                });
              },
            )
          ], //*needle pointer for gauge
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Text('${user.bmi}',
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
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              //*ListView for the profile items
              ProfileMenuWidget(
                titleText: 'BMI info',
                icon: LineAwesomeIcons.user,
                color: Colors.black,
                onTap: () {
                  MyApp.navigatorKey.currentState!.pushNamed('/bmiInfo');
                },
                endIcon: true,
              ),
              //*To display BMI result
              Card(
                color: Colors.white,
                elevation: 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180,
                        width: 180,
                        child: getRadialGauge(),
                      ),
                      Text(
                        bmiResult,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: bmitextColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              ProfileMenuWidget(
                titleText: user.email,
                icon: LineAwesomeIcons.envelope,
                color: Colors.black,
                onTap: () {
                  MyApp.navigatorKey.currentState!.pushNamed('/editEmail');
                },
                endIcon: true,
              ),
              ProfileMenuWidget(
                titleText: "user.password",
                icon: LineAwesomeIcons.lock,
                color: Colors.black,
                onTap: () {
                  MyApp.navigatorKey.currentState!.pushNamed('/editPwd');
                },
                endIcon: true,
              ),
              ProfileMenuWidget(
                titleText: user.phoneNumber,
                icon: LineAwesomeIcons.phone,
                color: Colors.black,
                onTap: () {
                  MyApp.navigatorKey.currentState!.pushNamed('/editPhoneNo');
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
                titleText: user.dateOfBirth,
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
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_dropdownbuttonformfield.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/cover_info.dart';

import '../../../model/users.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key, required this.user});
  final Users user;

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  @override
  Widget build(BuildContext context) {
    return CoverInfo(
      content: const BMIPageWidget(),
      title: 'BMI Info',
      users: widget.user,
    );
  }
}

class BMIPageWidget extends StatefulWidget {
  const BMIPageWidget({super.key});

  @override
  State<BMIPageWidget> createState() => _BMIPageWidgetState();
}

class _BMIPageWidgetState extends State<BMIPageWidget> {
  late String _selectedGender;
  final List<String> _genderOptions = ['Male', 'Female'];
  late TextEditingController weightEC;
  late TextEditingController heightEC;
  late TextEditingController bmiEC;
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _selectedGender = _genderOptions[0];
    weightEC = TextEditingController();
    heightEC = TextEditingController();
    bmiEC = TextEditingController();
  }

  @override
  void dispose() {
    weightEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final weightSnapshot = snapshot.data!['weight'];
            final heighSnapshot = snapshot.data!['height'];
            final genderSnapshot = snapshot.data!['gender'];
            bool genderIsSet = false;

            print("Gender snapshot: $genderSnapshot");
            print("outside genderIsSet: $genderIsSet");

            if (genderSnapshot != "") {
              genderIsSet = true;
              print("genderIsSet: $genderIsSet");
            }

            if (weightSnapshot != 0.0) {
              weightEC.text = weightSnapshot.toString();
            }

            if (heighSnapshot != 0.0) {
              heightEC.text = heighSnapshot.toString();
            }

            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDropdownButtonFormField(
                      labelText: 'Gender',
                      hintText: '',
                      selectedValue:
                          genderIsSet ? genderSnapshot : _selectedGender,
                      items: _genderOptions,
                      onChanged: genderIsSet
                          ? null
                          : (newValue) {
                              setState(() {
                                _selectedGender = newValue!;
                              });
                            }),
                  const SizedBox(
                    height: 20,
                  ),
                  //*Weight text field
                  CustomTextFormField(
                    context: context,
                    isNumberOnly: true,
                    maxLength: 5,
                    labelText: 'Weight (kg)',
                    controller: weightEC,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //*Height text field
                  CustomTextFormField(
                    context: context,
                    isNumberOnly: true,
                    maxLength: 5,
                    labelText: 'Height (cm)',
                    controller: heightEC,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                            onPressed: () {
                              String bmiResult;
                              Color bmiResultColor;

                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                final double weight =
                                    double.parse(weightEC.text);
                                final double height =
                                    double.parse(heightEC.text);
                                FirebaseFirestore db =
                                    FirebaseFirestore.instance;
                                final double bmi =
                                    weight / (height * height) * 10000;
                                bmiEC.text = bmi.toStringAsFixed(2);

                                db
                                    .collection("users")
                                    .doc(
                                      FirebaseAuth.instance.currentUser!.uid,
                                    )
                                    .update({
                                  "gender": _selectedGender,
                                  "weight": weightEC.text,
                                  "height": heightEC.text,
                                  "bmi": bmiEC.text,
                                }).then((value) {
                                  print(weight);
                                  print(height);
                                  print(bmi);
                                  print(_selectedGender);
                                  print('weight, height, bmi store success');
                                }).catchError((error) =>
                                        print('Failed to update bmi: $error'));

                                if (bmi < 18.5) {
                                  bmiResult = 'Underweight';
                                  bmiResultColor = Colors.blue;
                                } else if (bmi >= 18.5 && bmi < 25) {
                                  bmiResult = 'Normal';
                                  bmiResultColor = Colors.green;
                                } else if (bmi >= 25 && bmi < 30) {
                                  bmiResult = 'Overweight';
                                  bmiResultColor = Colors.yellow;
                                } else if (bmi >= 30 && bmi < 35) {
                                  bmiResult = 'Obese';
                                  bmiResultColor = Colors.orange;
                                } else {
                                  bmiResult = 'Extremely Obese';
                                  bmiResultColor = Colors.red;
                                }

                                print('weight: $weight');
                                print('height: $height');
                                print('bmi: ${bmiEC.text}');
                                print('bmi: $bmiResult');

                                //*show modal bmi result
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: const EdgeInsets.all(20.0),
                                        height: 250,
                                        child: Center(
                                          child: Column(children: [
                                            const ListTile(
                                              leading: Icon(
                                                  LineAwesomeIcons.info_circle,
                                                  color: Colors.black),
                                              title: Text(
                                                'BMI Result',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              bmiEC.text,
                                              style: const TextStyle(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              bmiResult,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: bmiResultColor),
                                            ),
                                          ]),
                                        ),
                                      );
                                    });
                              }
                            },
                            child: const Text('CALCULATE')),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomOutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          disabled: true,
                          iconData: null,
                          text: 'BACK',
                        ),
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
          return const Text('Error');
        });
  }
}

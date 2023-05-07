import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_dropdownbuttonformfield.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/cover_info.dart';

import '../profile_page.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  @override
  Widget build(BuildContext context) {
    return CoverInfo(
      content: const BMIPageWidget(),
      title: 'BMI Info',
      user: user,
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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomDropdownButtonFormField(
              labelText: 'Gender',
              hintText: '',
              selectedValue: _selectedGender,
              items: _genderOptions,
              onChanged: (newValue) {
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
              controller: weightEC),
          const SizedBox(
            height: 20,
          ),
          //*Height text field
          CustomTextFormField(
              context: context,
              isNumberOnly: true,
              maxLength: 5,
              labelText: 'Height (cm)',
              controller: heightEC),
          const SizedBox(
            height: 35,
          ),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                    onPressed: () {
                      //TODO: after that need refine the code here!
                      final double weight = double.parse(weightEC.text);
                      final double height = double.parse(heightEC.text);
                      String bmiResult;
                      Color bmiResultColor;

                      if (_formKey.currentState!.validate()) {
                        final double bmi = weight / (height * height) * 10000;
                        bmiEC.text = bmi.toStringAsFixed(2);

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
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
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
    return Column(
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
                    final double weight = double.parse(weightEC.text);
                    final double height = double.parse(heightEC.text);
                    final double bmi = weight / (height * height) * 10000;
                    bmiEC.text = bmi.toStringAsFixed(2);

                    String bmiResult;
                    if (bmi < 18.5) {
                      bmiResult = 'Underweight';
                    } else if (bmi >= 18.5 && bmi < 25) {
                      bmiResult = 'Normal';
                    } else if (bmi > 25 && bmi < 30) {
                      bmiResult = 'Overweight';
                    } else {
                      bmiResult = 'Obese';
                    }

                    print('weight: $weight');
                    print('height: $height');
                    print('bmi: ${bmiEC.text}');
                    print('bmi: $bmiResult');
                  },
                  child: const Text('CALCULATE')),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

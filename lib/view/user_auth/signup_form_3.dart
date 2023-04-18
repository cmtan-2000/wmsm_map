// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/shared/phone_number_field.dart';

class SignUpForm3 extends StatelessWidget {
  const SignUpForm3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Theme.of(context).primaryColor,
              ],
              stops: const [
                0.1,
                1.0,
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: FractionallySizedBox(
              child: Column(
                children: [
                  Text(
                    'Personal Information',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      // padding: const EdgeInsets.symmetric(
                      //     vertical: 55, horizontal: 30),
                      padding: const EdgeInsets.fromLTRB(30, 55, 30, 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: const content(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class content extends StatefulWidget {
  const content({
    super.key,
  });

  @override
  State<content> createState() => _contentState();
}

class _contentState extends State<content> {
  bool _selectedValue = false;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameEC;
  late TextEditingController nickEC;
  late TextEditingController typeEC;
  late TextEditingController noEC;
  late TextEditingController dobEC;
  late TextEditingController phoneEC;
  late TextEditingController emailEC;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameEC = TextEditingController();
    nickEC = TextEditingController();
    typeEC = TextEditingController();
    noEC = TextEditingController();
    dobEC = TextEditingController();
    phoneEC = TextEditingController();
    emailEC = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameEC.dispose();
    nickEC.dispose();
    typeEC.dispose();
    noEC.dispose();
    dobEC.dispose();
    phoneEC.dispose();
    emailEC.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobEC.text = DateFormat('yyyy-MM-dd').format(picked);
        print(dobEC);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set Up Profile',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Text(
                'help us to understand you better by filling up your Profile Information below.'),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: false,
                labelText: 'Name (as per IC)',
                hintText: 'JOHN DOE',
                controller: nameEC),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: false,
                maxLength: 10,
                labelText: 'Nickname',
                hintText: 'John',
                controller: nickEC),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: false,
                hintText: 'ID Type',
                controller: typeEC),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: true,
                labelText: 'ID Number',
                hintText: 'xxxxxx00xxxx',
                controller: noEC),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: true,
                labelText: 'Date of Birth',
                onTap: () => _selectDate(context),
                readOnly: true,
                suffixicon: const Icon(Icons.calendar_month),
                controller: dobEC),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: true,
                labelText: 'Phone Number',
                hintText: '60187797789',
                controller: phoneEC),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: false,
                labelText: 'Email Address',
                hintText: 'john_doe@graduate.utm.my',
                controller: emailEC),
            const SizedBox(
              height: 10,
            ),
            const Text('Are you a XXX Bank group empolyee? '),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: false,
                            groupValue: _selectedValue,
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value!;
                              });
                            })
                      ],
                    ),
                    const Text('No'),
                  ],
                ),
                Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: true,
                            groupValue: _selectedValue,
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value!;
                              });
                            })
                      ],
                    ),
                    const Text('Yes'),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('Validate data');
                          var profile = {
                            "name": nameEC.text.trim(),
                            "nick": nickEC.text.trim(),
                            "idType": typeEC.text.trim(),
                            "idno": noEC.text.trim(),
                            "dob": dobEC.text.trim(),
                            "phone": phoneEC.text.trim(),
                            "email": emailEC.text.trim(),
                          };

                          print(profile);
                        }
                      },
                      child: const Text('CONTINUE')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_dropdownbuttonformfield.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';

import '../../../main.dart';
import '../widgets/cover_content.dart';

class SignUpForm3 extends StatelessWidget {
  const SignUpForm3({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoverContent(
      content: SignUpForm3Widget(),
      title: 'Personal Information',
    );
  }
}

class SignUpForm3Widget extends StatefulWidget {
  const SignUpForm3Widget({
    super.key,
  });

  @override
  State<SignUpForm3Widget> createState() => _SignUpForm3WidgetState();
}

class _SignUpForm3WidgetState extends State<SignUpForm3Widget> {
  bool _selectedValue = false;
  late String _selectedIc;

  final List<String> _options = ['Identity Card', 'Passport', 'Others'];

  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameEC;
  late TextEditingController usernameEC;
  late TextEditingController typeEC;
  late TextEditingController noEC;
  late TextEditingController dobEC;
  late TextEditingController phoneEC;
  late TextEditingController emailEC;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIc = _options[0];
    nameEC = TextEditingController();
    usernameEC = TextEditingController();
    noEC = TextEditingController();
    dobEC = TextEditingController();
    phoneEC = TextEditingController();
    emailEC = TextEditingController();
  }

  @override
  void dispose() {
    nameEC.dispose();
    usernameEC.dispose();
    typeEC.dispose();
    noEC.dispose();
    dobEC.dispose();
    phoneEC.dispose();
    emailEC.dispose();
    super.dispose();
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
                hintText: 'TAN CHEE MING',
                controller: nameEC),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: false,
                maxLength: 10,
                labelText: 'Username',
                hintText: 'John',
                controller: usernameEC),
            const SizedBox(
              height: 10,
            ),
            CustomDropdownButtonFormField(
                labelText: 'Ic Type',
                hintText: '',
                selectedValue: _selectedIc,
                items: _options,
                onChanged: (newValue) {
                  setState(() {
                    _selectedIc = newValue!;
                  });
                }),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: true,
                labelText: 'IC number',
                hintText: '',
                controller: noEC),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: true,
                hintText: 'Date of Birth',
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
                hintText: 'Mobile',
                controller: phoneEC),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: false,
                hintText: 'Email Address',
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
                      onPressed: () => MyApp.navigatorKey.currentState!
                          .pushNamed('/signup4'),
                      child: const Text('CONTINUE')),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

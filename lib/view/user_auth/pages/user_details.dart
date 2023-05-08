import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';

import '../../../main.dart';
import '../../../model/users.dart';
import '../../../viewmodel/shared/shared_pref.dart';
import '../../shared/email_field.dart';
import '../../shared/phone_number_field.dart';
import '../widgets/cover_content.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoverContent(
      content: UserDetailsWidget(),
      title: 'Personal Information',
    );
  }
}

class UserDetailsWidget extends StatefulWidget {
  const UserDetailsWidget({
    super.key,
  });

  @override
  State<UserDetailsWidget> createState() => _UserDetailsWidgetState();
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {
  bool _selectedValue = false;

  final _formKey = GlobalKey<FormState>();
  late SharedPref sharedPref = SharedPref();
  late TextEditingController nameEC;
  late TextEditingController usernameEC;
  late TextEditingController typeEC;
  late TextEditingController noEC;
  late TextEditingController dobEC;
  late TextEditingController phoneEC;
  late TextEditingController emailEC;

  @override
  void initState() {
    super.initState();
    nameEC = TextEditingController();
    usernameEC = TextEditingController();
    noEC = TextEditingController();
    dobEC = TextEditingController();
    phoneEC = TextEditingController();
    emailEC = TextEditingController();
    typeEC = TextEditingController();
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
      });
    }
  }

  Future<void> storeData() async {
    Users user = Users(fullname: nameEC.text, username: usernameEC.text, email: emailEC.text.trim(), phoneNumber: phoneEC.text, dateOfBirth: dobEC.text);
    sharedPref.save("userData", user);
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
                controller: nameEC,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: false,
                maxLength: 10,
                labelText: 'Username',
                hintText: 'John',
                controller: usernameEC,   
              ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
                context: context,
                isNumberOnly: true,
                hintText: 'Date of Birth',
                labelText: 'Date of Birth',
                onTap: () => _selectDate(context),
                readOnly: true,
                suffixicon: const Icon(Icons.calendar_month),
                controller: dobEC,   
              ),
            const SizedBox(
              height: 10,
            ),
            phoneNumberField(
                phoneController: phoneEC,  
            ),
            const SizedBox(
              height: 10,
            ),
            EmailField(
                emailController: emailEC,       
            ),
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
                        if(_formKey.currentState!.validate()) {
                          sharedPref.remove('userData');
                          storeData();
                          MyApp.navigatorKey.currentState!.pushNamed('/setuppassword');
                        }
                      },
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

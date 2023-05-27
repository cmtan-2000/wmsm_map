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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Expanded(
          child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                    margin: const EdgeInsets.all(16),
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/images/etiqa.png', width: 99)),
                Expanded(child: SingleChildScrollView(
                    child: LayoutBuilder(builder: (context, constraints) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 1.05,
                    child: Column(
                      children: [
                        Text(
                          'Personal Information',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(30, 55, 30, 0),
                            child: const UserDetailsWidget(),
                          ),
                        )
                      ],
                    ),
                  );
                }))),
              ],
            ),
          ),
        )
      ]),
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
    Users user = Users(
        fullname: nameEC.text,
        username: usernameEC.text,
        email: emailEC.text.trim(),
        phoneNumber: phoneEC.text,
        dateOfBirth: dobEC.text,
        role: '');
    sharedPref.save("userData", user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Help us to understand you better by filling up your Profile Information below.'),
              const SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                context: context,
                isNumberOnly: false,
                labelText: 'Name (as per IC)',
                hintText: 'Ex: John Wick',
                controller: nameEC,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                context: context,
                isNumberOnly: false,
                maxLength: 10,
                labelText: 'Username',
                hintText: 'Ex: John',
                controller: usernameEC,
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 10,
              ),
              phoneNumberField(
                phoneController: phoneEC,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length < 9) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              EmailField(
                emailController: emailEC,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 30,
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
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            sharedPref.remove('userData');
                            storeData();
                            MyApp.navigatorKey.currentState!
                                .pushNamed('/setuppassword');
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
      ),
    );
  }
}

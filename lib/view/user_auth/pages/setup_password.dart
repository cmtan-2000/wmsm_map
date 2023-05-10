import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/viewmodel/shared/shared_pref.dart';

import '../../../model/users.dart';
import '../../custom/widgets/custom_elevatedbutton.dart';
import '../../shared/password_field.dart';
import '../widgets/cover_content.dart';

class SetupPassword extends StatelessWidget {
  const SetupPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoverContent(
      content: SetupPasswordWidget(),
      title: 'Password',
    );
  }
}

class SetupPasswordWidget extends StatefulWidget {
  const SetupPasswordWidget({super.key});

  @override
  State<SetupPasswordWidget> createState() => _SetupPasswordState();
}

class _SetupPasswordState extends State<SetupPasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  bool hasMatchError = false;
  SharedPref sharedPref = SharedPref();
  Users userLoad = Users(
      dateOfBirth: '', email: '', fullname: '', phoneNumber: '', username: '');

  late TextEditingController _password;
  late TextEditingController _passwordConfirm;

  @override
  void initState() {
    _password = TextEditingController();
    _passwordConfirm = TextEditingController();
    super.initState();
    initialGetSavedData();
  }

  void initialGetSavedData() async {
    Users user = Users.fromJson(await sharedPref.read("userData"));
    setState(() {
      userLoad = user;
    });
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<bool> signUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userLoad.email,
        password: _password.text.trim(),
      );
      addUserDetails();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e is PlatformException) {
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          return false;
        }
      }
    }
    return false;
  }

  Future addUserDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'fullname': userLoad.fullname,
      'username': userLoad.username,
      'email': userLoad.email,
      'phoneNumber': userLoad.phoneNumber,
      'bmi': 0,
      'gender': '',
      'weight': 0,
      'height': 0,
      'profile_picture':
          'https://i1.sndcdn.com/avatars-000307598863-zfe44f-t500x500.jpg',
      'dateOfBirth': userLoad.dateOfBirth,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Help us to understand you better by filling up your Profile Information below. ',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                passwordField(
                    passwordController: _password,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 6) {
                        return "Please enter at least 6 characters";
                      }
                    }),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirm Password',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                passwordField(
                    passwordController: _passwordConfirm,
                    hintText: "Confirm your password",
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 6) {
                        return "Please enter at least 6 characters";
                      }
                    }),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                hasMatchError ? "*Password didn't match. Please try again" : "",
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        if (_password.text != _passwordConfirm.text) {
                          setState(() {
                            hasMatchError = true;
                          });
                          return;
                        }
                        setState(() => hasMatchError = false);
                        if (await signUp()) {
                          snackBar("Sign Up Successfully!");
                        } else {
                          snackBar("Email already in use!");
                        }
                        sharedPref.remove('users');
                        MyApp.navigatorKey.currentState!
                            .popUntil((route) => route.isFirst);
                      },
                      child: const Text('COMPLETE')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

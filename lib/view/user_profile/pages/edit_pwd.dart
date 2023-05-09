import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/user_profile/profile_page.dart';
import 'package:wmsm_flutter/view/user_profile/widgets/cover_info.dart';

import '../../../main.dart';
import '../../../model/users.dart';
import '../../shared/password_field.dart';

//!rmb to ask them if still need this page

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  @override
  Widget build(BuildContext context) {
    return CoverInfo(
      content: const EditPwdPageWidget(),
      title: 'Edit Password',
      users: users,
    );
  }
}

class EditPwdPageWidget extends StatefulWidget {
  const EditPwdPageWidget({super.key});

  @override
  State<EditPwdPageWidget> createState() => _EditPwdPageWidgetState();
}

class _EditPwdPageWidgetState extends State<EditPwdPageWidget> {
  bool hasPwdError = false;
  bool hasMatchError = false;
  late TextEditingController currentpwdEC;
  late TextEditingController pwdEC;
  late TextEditingController confirmpwdEC;
  final _formKey = GlobalKey<FormState>();
  bool checkCurrentPasswordValid = true;

  @override
  void initState() {
    super.initState();
    pwdEC = TextEditingController();
    currentpwdEC = TextEditingController();
    confirmpwdEC = TextEditingController();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<bool> checkCurrentPassword(String password, String newpassword) async {
    final user = FirebaseAuth.instance.currentUser!;

    var authCredentials = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    try {
      await user.reauthenticateWithCredential(authCredentials);
      user.updatePassword(newpassword);
    } catch (e) {
      return false;
    }
    return false;
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
              'Current Password',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            /* ListTile(
              leading: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor),
                child: const Icon(LineAwesomeIcons.lock, color: Colors.black),
              ),
            ), */
            passwordField(
              passwordController: currentpwdEC,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                hasPwdError ? "*Incorrect Current Password" : "",
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'New Password',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            passwordField(
                passwordController: pwdEC,
                hintText: "New Password",
                validator: (value) {
                  if (value.length < 6) {
                    return "Please enter at least 6 characters";
                  }
                }),
            const SizedBox(height: 20.0),
            Text(
              'Confirm New Password',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            passwordField(
                passwordController: confirmpwdEC,
                hintText: "Confirm your password",
                validator: (value) {
                  if (value.length < 6) {
                    return "Please enter at least 6 characters";
                  }
                }),
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
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (pwdEC.text != confirmpwdEC.text) {
                            setState(() {
                              hasMatchError = true;
                            });
                            return;
                          }
                          setState(() => hasMatchError = false);
                          if (!await checkCurrentPassword(
                              currentpwdEC.text, pwdEC.text)) {
                            setState(() {
                              hasPwdError = true;
                            });
                            return;
                          }
                          setState(() => hasPwdError = false);
                          snackBar("Update successfully!");
                          MyApp.navigatorKey.currentState!.pop();
                        }
                      },
                      child: const Text('UPDATE')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

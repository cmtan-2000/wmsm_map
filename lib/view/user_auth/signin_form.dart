// ignore_for_file: deprecated_member_use, camel_case_types, avoid_print

import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_button.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/shared/passcode_field.dart';
import 'package:wmsm_flutter/view/user_auth/signup_form.dart';
import 'package:wmsm_flutter/viewmodel/user_auth/authentication_model.dart';

import '../shared/email_field.dart';
import '../shared/password_field.dart';

class WidgetSignIn extends StatefulWidget {
  const WidgetSignIn({super.key});

  @override
  State<WidgetSignIn> createState() => _WidgetSignInState();
}

class _WidgetSignInState extends State<WidgetSignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthenticationViewModel auth = AuthenticationViewModel();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationViewModel authfunc = AuthenticationViewModel();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Sign In',
              style: Theme.of(context).textTheme.headline1,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EMAIL ADDRESS',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  emailField(
                    emailController: _emailController,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PASSWORD',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  passwordField(
                    passwordController: _passwordController,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomTextButton(
                  context: context,
                  text: "Reset Password",
                  onPressed: () => print(""),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    // onPressed: () => authfunc.login(),
                    onPressed: () {
                      // Todo: Authentication
                      if(_formKey.currentState!.validate()) {
                        signIn();
                        //Navigator.of(context).pushNamed('/intro');
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
            const WidgetSignUp()
          ]),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }
}

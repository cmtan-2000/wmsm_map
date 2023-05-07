import 'package:flutter/material.dart';
import 'package:wmsm_flutter/main.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_button.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
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
  final AuthenticationViewModel auth = AuthenticationViewModel();
  // final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _passcode = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationViewModel authfunc = AuthenticationViewModel();
  final _formKey = GlobalKey<FormState>();

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
                  EmailField(
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
                    onPressed: () {
                      MyApp.navigatorKey.currentState!.pushNamed('/resetpwd');
                      print("");
                    })
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    // onPressed: () => authfunc.login(),
                    onPressed: () {
                      // Todo: Authentication
                      if (_formKey.currentState!.validate()) {
                        print(_passwordController.text.trim());
                        Navigator.of(context).pushNamed('/intro');
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
            const Center(child: WidgetSignUp())
          ]),
    );
  }

  // Future signIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: _emailController.text.trim(),
  //     password: _passwordController.text.trim(),
  //   );
  // }
}

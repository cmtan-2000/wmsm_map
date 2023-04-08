/* 
consist of:
  sign-in.dart
  sign-up.dart
  forget-password.dart.
*/

import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/user_auth/signin_form.dart';
import 'package:wmsm_flutter/view/user_auth/signup_form.dart';

class AuthenticatePage extends StatelessWidget {
  const AuthenticatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: const [
              Text('data'),
              WidgetSignIn(),
              WidgetSignUp(),
              
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../viewmodel/user_auth/authentication_model.dart';

class WidgetSignUp extends StatefulWidget {
  const WidgetSignUp({super.key});

  @override
  State<WidgetSignUp> createState() => _WidgetSignUpState();
}

class _WidgetSignUpState extends State<WidgetSignUp> {

  final AuthenticationViewModel auth = AuthenticationViewModel();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()=> auth.login(), 
      child: const Text('login Button'),
    );
  }
}
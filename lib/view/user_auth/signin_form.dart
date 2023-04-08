import 'package:flutter/material.dart';
import 'package:wmsm_flutter/viewmodel/user_auth/authentication_model.dart';

class WidgetSignIn extends StatefulWidget {
  const WidgetSignIn({super.key});

  @override
  State<WidgetSignIn> createState() => _WidgetSignInState();
}

class _WidgetSignInState extends State<WidgetSignIn> {

  final AuthenticationViewModel auth = AuthenticationViewModel();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()=> auth.login(), 
      child: const Text('login Button'),
    );
  }
}

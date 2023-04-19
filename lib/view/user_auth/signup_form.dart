import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_button.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        CustomTextButton(
          text: 'Sign up',
          context: context,
          onPressed: () {
            Navigator.pushNamed(context, '/f1');
          },
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

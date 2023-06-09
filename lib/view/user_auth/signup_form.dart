import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_button.dart';

import '../../main.dart';
import '../../viewmodel/user_auth/authentication_model.dart';
import '../custom/themes/custom_theme.dart';

class WidgetSignUp extends StatefulWidget {
  const WidgetSignUp({super.key});

  @override
  State<WidgetSignUp> createState() => _WidgetSignUpState();
}

class _WidgetSignUpState extends State<WidgetSignUp> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //if (constraints.maxWidth > Config.minWidth) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account? "),
            CustomTextButton(
                text: 'Sign up',
                context: context,
                onPressed: () {
                  MyApp.navigatorKey.currentState!.pushNamed('/userdetails');
                },
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                minimumSize: const Size(0, 0)),
            const SizedBox(
              height: 20,
            ),
          ],
        );
        /* } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account? "),
              CustomTextButton(
                  text: 'Sign up',
                  context: context,
                  onPressed: () {
                    MyApp.navigatorKey.currentState!.pushNamed('/userdetails');
                  },
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  minimumSize: const Size(0, 0)),
            ],
          );
        } */
      },
    );
  }
}

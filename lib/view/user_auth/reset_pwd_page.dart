import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/user_auth/widgets/cover_content.dart';

import '../../main.dart';
import '../shared/email_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return const CoverContent(
      content: ResetPasswordWidget(),
      title: 'Forgot Password',
    );
  }
}

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({super.key});

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailEC;

  @override
  void initState() {
    super.initState();
    _emailEC = TextEditingController();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailEC.text.trim(),
      );
      snackBar("Sent link to email");
      MyApp.navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      snackBar("Invalid email entered");
    }
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Reset Password',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              'Enter your email and a link to reset your password will be sent to you via email.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 40,
            ),
            emailField(
              emailController: _emailEC,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        passwordReset();
                      }
                    },
                    child: const Text('CONFIRM EMAIL'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

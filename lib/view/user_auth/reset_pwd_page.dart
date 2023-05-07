import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/user_auth/widgets/cover_content.dart';

import '../../main.dart';

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

  @override
  void dispose() {
    super.dispose();
    _emailEC.dispose();
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
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Text(
                'Enter your email and a link to reset your password will be sent to you via email.'),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              context: context,
              isNumberOnly: false,
              labelText: 'Email',
              controller: _emailEC,
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            snackBar("Sent link to email");
                            //TODO: sent link to email
                          }
                        },
                        child: const Text('CONFIRM EMAIL'),
                      ),
                    ),
                  ],
                ),
                CustomOutlinedButton(
                  onPressed: () {
                    MyApp.navigatorKey.currentState!.pop();
                  },
                  disabled: false,
                  iconData: null,
                  text: 'Back',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

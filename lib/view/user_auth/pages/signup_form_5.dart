import 'package:flutter/material.dart';
import 'package:wmsm_flutter/main.dart';

import '../../custom/widgets/custom_elevatedbutton.dart';
import '../../shared/password_field.dart';
import '../widgets/cover_content.dart';

class SignUpForm5 extends StatelessWidget {
  const SignUpForm5({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoverContent(
      content: SignUpForm5Widget(),
      title: 'Password',
    );
  }
}

class SignUpForm5Widget extends StatefulWidget {
  const SignUpForm5Widget({super.key});

  @override
  State<SignUpForm5Widget> createState() => _WidgetSignUp5State();
}

class _WidgetSignUp5State extends State<SignUpForm5Widget> {
  final _formKey = GlobalKey<FormState>();
  bool hasSetError = false;
  bool hasCfmError = false;
  bool hasMatchError = false;

  late TextEditingController _password;
  late TextEditingController _passwordConfirm;

  late String password;
  late String passwordError;
  

  @override
  void initState() {
    _password = TextEditingController();
    _passwordConfirm = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _password.dispose();
    _passwordConfirm.dispose();
    super.dispose();
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Set Up Password For your Account',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Text(
            'Help us to understand you better by filling up your Profile Information below. ',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set your password',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 30,
              ),
              passwordField(
                passwordController: _password,
              ),
            ],
          ),
          /* Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              hasSetError ? "*Please fill up your password." : " ",
              style: const TextStyle(
                  color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ), */
          const SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Confirm your password',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 30,
              ),
              passwordField(
                passwordController: _passwordConfirm,
              ),
            ],
          ),
          /* Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              hasCfmError ? "*Please fill up your password." : "",
              style: const TextStyle(
                  color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ), */
          /* Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              hasMatchError ? "*Password didn't match. Please try again" : "",
              style: const TextStyle(
                  color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ), */
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                    onPressed: () {
                      // print(validatePasscode(_passcode.text.trim(), _passcodeConfirm.text.trim()));
                      /* _formKey.currentState!.validate();
                      if (_password.text.length > 0  && _password.text.length != 6) {
                        setState(() => hasSetError = true);
                        return;
                      }
                      setState(() => hasSetError = false);
                      if (_password.text.length > 0  &&_passwordConfirm.text.length != 6) {
                        setState(() => hasCfmError = true);
                        return;
                      }
                      setState(() => hasCfmError = false); 
                      if (_password.text != _passwordConfirm.text) {
                        setState(() {
                          hasMatchError = true;
                        });
                        return;
                      }
                      setState(() => hasMatchError = false); */

                      snackBar("submit");
                      MyApp.navigatorKey.currentState!.pushNamed('/');
                      // Todo: logic
                      // Data can used:
                      // _passcode.text
                      // _passcodeConfirm.text
                    },
                    child: const Text('COMPLETE')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

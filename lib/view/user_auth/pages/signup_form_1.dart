// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../custom/widgets/custom_checkbox.dart';
import '../../custom/widgets/custom_elevatedbutton.dart';
import '../../shared/phone_number_field.dart';
import '../widgets/cover_content.dart';

class SignUpForm1 extends StatefulWidget {
  const SignUpForm1({super.key});

  @override
  State<SignUpForm1> createState() => _SignUpForm1State();
}

class _SignUpForm1State extends State<SignUpForm1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CoverContent(
      content: SignUpForm1Widget(),
      title: 'Consent Form',
    );
  }
}

class SignUpForm1Widget extends StatefulWidget {
  SignUpForm1Widget({super.key});

  @override
  State<SignUpForm1Widget> createState() => _SignUpForm1WidgetState();
}

class _SignUpForm1WidgetState extends State<SignUpForm1Widget> {
  late TextEditingController _phoneController;
  bool isChecked = true;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Sign Up',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            'Signing up is easy. Just fill up the details and you are set to go',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Phone number'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                phoneNumberField(
                  phoneController: _phoneController,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/sign_up.png',
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Row(
            children: const [
              Expanded(
                  child: CustomCheckBox(
                text:
                    "I custom to processing of my persona data (including sensitive personal data) in accordance with Etiqa's Privacy Notice and I agree to the Terms and Conditions",
              )),
            ],
          ), // const SizedBox(height: 20
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  child: Text('Request otp'.toUpperCase()),
                  onPressed: () {
                    if (isChecked) {
                      MyApp.navigatorKey.currentState!.pushNamed('/signup2');
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          
        ],
      ),
    );
  }
}

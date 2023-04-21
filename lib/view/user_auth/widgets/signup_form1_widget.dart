import 'package:flutter/material.dart';

import '../../custom/widgets/custom_checkbox.dart';
import '../../custom/widgets/custom_elevatedbutton.dart';
import '../../shared/phone_number_field.dart';

class SignUpForm1Widget extends StatefulWidget {
  const SignUpForm1Widget({super.key});

  @override
  State<SignUpForm1Widget> createState() => _SignUpForm1Widget();
}

class _SignUpForm1Widget extends State<SignUpForm1Widget> {
  final TextEditingController _phoneController = TextEditingController();
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 70,
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
            Expanded(child: CustomCheckBox()),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                child: Text('Request otp'.toUpperCase()),
                onPressed: () {
                  if (isChecked) {
                    print('isChecked');
                    Navigator.pushNamed(context, '/f2');
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

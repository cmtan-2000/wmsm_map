import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/shared/passcode_field.dart';

class SignUpForm5Widget extends StatefulWidget {
  const SignUpForm5Widget({super.key});

  @override
  State<SignUpForm5Widget> createState() => _WidgetSignUp5State();
}

class _WidgetSignUp5State extends State<SignUpForm5Widget> {
  final TextEditingController _passcode = TextEditingController();
  final TextEditingController _passcodeConfirm = TextEditingController();
  late String passcode;
  late String passcodeError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set Up Passcode',
          style: Theme.of(context).textTheme.displayLarge,
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
              'Set your passcode',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            passCodeField(
              passcodeController: _passcode,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirm your passcode',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            passCodeField(
              passcodeController: _passcodeConfirm,
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                  onPressed: () {
                    print(validatePasscode(
                        _passcode.text.trim(), _passcodeConfirm.text.trim()));
                  },
                  child: const Text('COMPLETE')),
            ),
          ],
        ),
      ],
    );
  }
}

String validatePasscode(String passcode, String confirmPasscode) {
  if (passcode != confirmPasscode) {
    return 'Passcodes do not match';
  } else {
    return "";
  }
}

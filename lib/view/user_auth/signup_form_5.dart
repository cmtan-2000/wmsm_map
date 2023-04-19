import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/shared/passcode_field.dart';

class SignUpForm5 extends StatelessWidget {
  const SignUpForm5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Theme.of(context).primaryColor,
              ],
              stops: const [
                0.1,
                1.0,
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: FractionallySizedBox(
              child: Column(
                children: [
                  Text(
                    'Digit Passcode',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      // padding: const EdgeInsets.symmetric(
                      //     vertical: 55, horizontal: 30),
                      padding: const EdgeInsets.fromLTRB(30, 55, 30, 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: const WidgetSignUp5(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class WidgetSignUp5 extends StatefulWidget {
  const WidgetSignUp5({super.key});

  @override
  State<WidgetSignUp5> createState() => _WidgetSignUp5State();
}

class _WidgetSignUp5State extends State<WidgetSignUp5> {
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

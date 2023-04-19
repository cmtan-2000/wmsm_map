import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/shared/passcode_field.dart';

import '../custom/widgets/custom_outlinedbutton.dart';

class SignUpForm4 extends StatelessWidget {
  const SignUpForm4({super.key});

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
                    'EMAIL VERIFICATION',
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
                      child: const WidgetSignUp4(),
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

class WidgetSignUp4 extends StatefulWidget {
  const WidgetSignUp4({super.key});

  @override
  State<WidgetSignUp4> createState() => _WidgetSignUp4State();
}

class _WidgetSignUp4State extends State<WidgetSignUp4> {
  final TextEditingController _passcode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'A validation code has been sent to the mailbox of eunicelim1520@gmail.com',
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verification Code',
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
          height: 40,
        ),
        Row(
          children: [
            Expanded(
              child: CustomOutlinedButton(
                iconData: null,
                context: context,
                onPressed: () => print('next page'),
                text: 'RESEND LINK',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                  onPressed: () {
                    print(_passcode.text.trim());
                    Navigator.pushNamed(context, '/f5');
                  },
                  child: const Text('CONTINUE')),
            ),
          ],
        )
      ],
    );
  }
}

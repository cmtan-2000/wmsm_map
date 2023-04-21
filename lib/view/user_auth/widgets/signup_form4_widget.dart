import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';
import 'package:wmsm_flutter/view/shared/passcode_field.dart';

class SignUpForm4Widget extends StatefulWidget {
  const SignUpForm4Widget({super.key});

  @override
  State<SignUpForm4Widget> createState() => _WidgetSignUp4State();
}

class _WidgetSignUp4State extends State<SignUpForm4Widget> {
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

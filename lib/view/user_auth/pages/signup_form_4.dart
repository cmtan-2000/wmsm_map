import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../custom/widgets/custom_elevatedbutton.dart';
import '../../custom/widgets/custom_outlinedbutton.dart';
import '../../shared/passcode_field.dart';
import '../widgets/cover_content.dart';

class SignUpForm4 extends StatelessWidget {
  const SignUpForm4({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoverContent(
      content: SignUpForm4Widget(),
      title: 'Email Verification',
    );
  }
}

class SignUpForm4Widget extends StatefulWidget {
  const SignUpForm4Widget({super.key});

  @override
  State<SignUpForm4Widget> createState() => _WidgetSignUp4State();
}

class _WidgetSignUp4State extends State<SignUpForm4Widget> {
  late TextEditingController _passcode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passcode = TextEditingController();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _passcode.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                  disabled: false,
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
                      MyApp.navigatorKey.currentState!.pushNamed('/signup5');
                    },
                    child: const Text('CONTINUE')),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
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
      ),
    );
  }
}

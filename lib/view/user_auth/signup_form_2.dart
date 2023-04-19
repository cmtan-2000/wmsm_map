import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_outlinedbutton.dart';
import 'package:wmsm_flutter/view/shared/passcode_field.dart';

class SignUpForm2 extends StatefulWidget {
  const SignUpForm2({super.key});

  @override
  State<SignUpForm2> createState() => _SignUpForm2State();
}

class _SignUpForm2State extends State<SignUpForm2> {
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
                    'Phone verification'.toUpperCase(),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.fromLTRB(30, 55, 30, 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: const ContentClass(),
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

class OTPTimer extends StatefulWidget {
  const OTPTimer({super.key});

  @override
  State<OTPTimer> createState() => _OTPTimerState();
}

class _OTPTimerState extends State<OTPTimer> {
  final int duration = 30;
  late CountdownController countdownController;

  @override
  void initState() {
    super.initState();
    countdownController = CountdownController(
      duration: Duration(seconds: duration),
      onEnd: () {
        print('Countdown Ended');
      },
    );
    countdownController.start(); //*start the timer
  }

  @override
  void dispose() {
    countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      countdownController: countdownController,
      builder: (BuildContext context, Duration remaining) {
        return CustomOutlinedButton(
            iconData: null,
            context: context,
            onPressed: () {
              print('Pressed resend link');
            },
            text: 'Resend (${remaining.inSeconds})');
      },
    );
  }
}

class ContentClass extends StatefulWidget {
  const ContentClass({super.key});

  @override
  State<ContentClass> createState() => _ContentClassState();
}

class _ContentClassState extends State<ContentClass> {
  final TextEditingController _passcode = TextEditingController();

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
        Text(
          'Phone number'.toUpperCase(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        //*Phone number row
        Row(
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Image.network(
                'https://flagsapi.com/MY/flat/64.png',
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image.asset("assets/images/64.png");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 20.0),
              child: Text(
                '+6011-12345678', //TODO: Get phone number from user
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const OTPTimer(),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        //*OTP boxes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PASSCODE',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            passCodeField(
              passcodeController: _passcode,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                onPressed: () {
                  print('Pressed continue');
                  Navigator.pushNamed(context, '/f3');
                },
                child: Text(
                  'Continue'.toUpperCase(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

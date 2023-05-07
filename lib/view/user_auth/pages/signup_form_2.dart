import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../custom/widgets/custom_elevatedbutton.dart';
import '../../custom/widgets/custom_timer.dart';
import '../../shared/passcode_field.dart';
import '../widgets/cover_content.dart';

class SignUpForm2 extends StatefulWidget {
  const SignUpForm2({super.key});

  @override
  State<SignUpForm2> createState() => _SignUpForm2State();
}

class _SignUpForm2State extends State<SignUpForm2> {
  @override
  Widget build(BuildContext context) {
    return const CoverContent(
      content: SignUpForm2Widget(),
      title: 'Phone Verification',
    );
  }
}

class SignUpForm2Widget extends StatefulWidget {
  const SignUpForm2Widget({super.key});

  @override
  State<SignUpForm2Widget> createState() => _SignUpForm2WidgetState();
}

class _SignUpForm2WidgetState extends State<SignUpForm2Widget> {
  late TextEditingController _passcode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passcode = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _passcode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
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
              height: 50,
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
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(
                    '+6011-12345678', //TODO: Get phone number from user
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const CustomTimer(),
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
                      MyApp.navigatorKey.currentState!.pushNamed('/signup3');
                    },
                    child: Text(
                      'Continue'.toUpperCase(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

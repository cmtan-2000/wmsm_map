import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wmsm_flutter/main.dart';

import '../../custom/widgets/custom_elevatedbutton.dart';
import '../../shared/passcode_field.dart';
import '../widgets/cover_content.dart';

class SignUpForm5 extends StatelessWidget {
  const SignUpForm5({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoverContent(
      content: SignUpForm5Widget(),
      title: 'Digit Passcode',
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
  StreamController<ErrorAnimationType>? errorSetController;
  StreamController<ErrorAnimationType>? errorConfirmController;

  late TextEditingController _passcode;
  late TextEditingController _passcodeConfirm;

  late String passcode;
  late String passcodeError;

  @override
  void initState() {
    _passcode = TextEditingController();
    _passcodeConfirm = TextEditingController();
    errorSetController = StreamController<ErrorAnimationType>();
    errorConfirmController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    errorSetController!.close();
    errorConfirmController!.close();
    _passcode.dispose();
    _passcodeConfirm.dispose();
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
            'Set Up Passcode',
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
                'Set your passcode',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 30,
              ),
              passCodeField(
                passcodeController: _passcode,
                errorController: errorSetController,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              hasSetError ? "*Please fill up your passcode." : " ",
              style: const TextStyle(
                  color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
            ),
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
                errorController: errorConfirmController,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              hasCfmError ? "*Please fill up your passcode." : "",
              style: const TextStyle(
                  color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              hasMatchError ? "*Passcode didn't match. Please try again" : "",
              style: const TextStyle(
                  color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                    onPressed: () {
                      // print(validatePasscode(_passcode.text.trim(), _passcodeConfirm.text.trim()));
                      _formKey.currentState!.validate();
                      if (_passcode.text.length != 6) {
                        errorSetController!.add(ErrorAnimationType.shake);
                        setState(() => hasSetError = true);
                        return;
                      }
                      setState(() => hasSetError = false);
                      if (_passcodeConfirm.text.length != 6) {
                        errorConfirmController!.add(ErrorAnimationType.shake);
                        setState(() => hasCfmError = true);
                        return;
                      }
                      setState(() => hasCfmError = false);
                      if (_passcode.text != _passcodeConfirm.text) {
                        errorSetController!.add(ErrorAnimationType.shake);
                        errorConfirmController!.add(ErrorAnimationType.shake);
                        setState(() {
                          hasMatchError = true;
                        });
                        return;
                      }
                      setState(() => hasMatchError = false);

                      print(_passcode.text);

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

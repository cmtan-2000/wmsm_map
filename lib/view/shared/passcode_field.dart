import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class passCodeField extends StatelessWidget {
  passCodeField({
    super.key,
    required this.passcodeController,
    this.errorController,
    Null Function(dynamic value)? onChanged,
  });
  TextEditingController passcodeController;
  StreamController<ErrorAnimationType>? errorController;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      PinCodeTextField(
        controller: passcodeController,
        errorAnimationController: errorController,
        length: 6,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        showCursor: false,
        onChanged: (String value) {},
        onSubmitted: (String value) => print(value),
        onCompleted: (v) => debugPrint("Completed"),
        beforeTextPaste: (text) {
          debugPrint("Allowing to paste $text");
          return true;
        },
        appContext: context,
      ),
    ]);
  }
}

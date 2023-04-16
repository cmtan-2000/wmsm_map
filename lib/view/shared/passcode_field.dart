import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class passCodeField extends StatelessWidget {
  const passCodeField({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      PinCodeTextField(
        length: 6,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        showCursor: false,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        appContext: context,
        animationType: AnimationType.fade,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            disabledColor: Colors.grey,
            inactiveColor: Colors.grey,
            activeColor: Colors.black,
            selectedColor: Colors.black,
            borderWidth: 1.5),
        validator: (value) {
          value!.length < 6
              ? 'Please enter the code'
              : value.length == 6
                  ? print("success")
                  : null;
          return null;
        },
        onChanged: (String value) {},
        onSubmitted: (String value) => print(value),
      ),
    ]);
  }
}

import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});
  //final void Function(bool isChecked) onCheckedChanged; //callback function

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        "I Custom to processing of my persona data (including sensitive personal data) in accordance with Etiqa's Privacy Notice and I agree to the Terms and Conditions",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false;
          //widget.onCheckedChanged(
          //    isChecked); //*call the callback func with new value
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Theme.of(context).primaryColor,
    );
  }
}

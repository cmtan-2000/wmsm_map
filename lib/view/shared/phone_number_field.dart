// ignore_for_file: camel_case_types, implementation_imports

import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';

// ignore: unused_element
class phoneNumberField extends StatelessWidget {
  const phoneNumberField(
      {super.key,
      required TextEditingController phoneController,
      this.textInputAction,
      this.validator})
      : _phoneController = phoneController;

  final TextEditingController _phoneController;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: CustomTextFormField(
            hintText: 'Ex: 123456789',
            labelText: 'Phone Number',
            context: context,
            isNumberOnly: true,
            controller: _phoneController,
            icon: Icons.phone,
            prefixText: '+60 ',
            textInputAction: textInputAction,
            validator: validator,
          ),
        )
      ],
    );
  }
}

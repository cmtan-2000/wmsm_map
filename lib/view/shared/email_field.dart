// ignore_for_file: camel_case_types, implementation_imports

import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:email_validator/email_validator.dart';

// ignore: unused_element
class emailField extends StatelessWidget {
   const emailField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: CustomTextFormField(
            hintText: 'Email',
            context: context,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            icon: Icons.email,
            validator: (value) {
              if(!EmailValidator.validate(value)) {
                return "Please enter a valid email address";
              }
              return null;
            },
          ),
        )
      ],
    );
  }
}
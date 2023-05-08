import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:email_validator/email_validator.dart';

// ignore: unused_element
class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required TextEditingController emailController,
    required 
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
            labelText: 'Email',
            context: context,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            icon: Icons.email,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if(value.isEmpty) {
                return "Please enter your email address";
              }
              if (!EmailValidator.validate(value)) {
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

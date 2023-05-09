// ignore_for_file: camel_case_types, implementation_imports, must_be_immutable
import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';

// ignore: unused_element
class passwordField extends StatefulWidget {
  const passwordField({
    super.key,
    required TextEditingController passwordController,
    String? hintText,
    this.textInputAction,
  })  : _passwordController = passwordController,
        _hintText = hintText;
  final TextEditingController _passwordController;
  final String? _hintText;
  final TextInputAction? textInputAction;
  @override
  State<passwordField> createState() => _passwordFieldState();
}

class _passwordFieldState extends State<passwordField> {
  bool passenable = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: CustomTextFormField(
            hintText: widget._hintText ?? 'Password',
            labelText: 'Password',
            context: context,
            controller: widget._passwordController,
            textInputAction: widget.textInputAction,
            icon: Icons.password,
            obscureText: passenable,

            // suffix: Row(
            //   children: [
            //     IconButton(
            //       onPressed: () {
            //         setState(() {
            //           if (passenable) {
            //             passenable = false;
            //           } else {
            //             passenable = true;
            //           }
            //         });
            //       },
            //       icon: Icon(passenable == true
            //           ? Icons.visibility_off
            //           : Icons.visibility),
            //     ),
            //   ],
            // ),

            validator: (value) {
              if (value.isEmpty) {
                return "Please enter your password";
              }
              if (value.length < 6) {
                return "Password must be more than 6 characters";
              }
              return null;
            },
          ),
        )
      ],
    );
  }
}

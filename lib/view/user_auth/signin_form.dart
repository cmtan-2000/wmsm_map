// ignore_for_file: deprecated_member_use, camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_button.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_elevatedbutton.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';
import 'package:wmsm_flutter/view/shared/passcode_field.dart';
import 'package:wmsm_flutter/view/shared/phone_number_field.dart';
import 'package:wmsm_flutter/view/user_auth/signup_form.dart';
import 'package:wmsm_flutter/viewmodel/user_auth/authentication_model.dart';

class WidgetSignIn extends StatefulWidget {
  const WidgetSignIn({super.key});

  @override
  State<WidgetSignIn> createState() => _WidgetSignInState();
}

class _WidgetSignInState extends State<WidgetSignIn> {
  final AuthenticationViewModel auth = AuthenticationViewModel();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passcode = TextEditingController();
  final AuthenticationViewModel authfunc = AuthenticationViewModel();

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Sign In',
            style: Theme.of(context).textTheme.headline1,
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PHONE NUMBER',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                phoneNumberField(
                  phoneController: _phoneController,
                ),
              ],
            ),
          ),
          Container(
            // padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PASSCODE',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                passCodeField(passcodeController: _passcode,),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButton(
                context: context,
                text: "Reset Password",
                onPressed: () => print(_passcode.text.trim()),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () => authfunc.login(),
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
          const WidgetSignUp()
        ]);
  }
}

class _buildPhoneInputField extends StatelessWidget {
  const _buildPhoneInputField({required TextEditingController phoneController})
      : _phoneController = phoneController;

  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
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
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: CustomTextFormField(
            context: context,
            isNumberOnly: true,
            controller: _phoneController,
            icon: Icons.phone,
          ),
        )
      ],
    );
  }
}

// class _buildPhoneInputField extends StatelessWidget {
//   const _buildPhoneInputField({required TextEditingController phoneController})
//       : _phoneController = phoneController;

//   final TextEditingController _phoneController;

//   @override
//   Widget build(BuildContext context) {
//     return CustomTextField(
//       label: 'Phone No',
//       controller: _phoneController,
//       isNumberOnly: true,
//     );
//   }
// }

class _buildCountryCodeSelector extends StatelessWidget {
  const _buildCountryCodeSelector();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 30,
        height: 30,
        child: Image.network(
          'https://flagsapi.com/MY/flat/64.png',
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Image.asset('assets/images/64.png');
          },
        ));
  }
}

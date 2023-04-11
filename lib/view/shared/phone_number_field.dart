// ignore_for_file: camel_case_types, implementation_imports

import 'package:flutter/material.dart';
import 'package:wmsm_flutter/view/custom/widgets/custom_textformfield.dart';

// ignore: unused_element
class phoneNumberField extends StatelessWidget {
  const phoneNumberField({
    super.key,
    required TextEditingController phoneController,
  }) : _phoneController = phoneController;

  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
            hintText: 'Phone Number',
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
// ignore_for_file: annotate_overrides, overridden_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class CustomTextField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;
//   final bool isNumberOnly;
//   final int? maxNumberLength;
//   final int? maxLines;

//   const CustomTextField(
//       {Key? key,
//       required this.hintText,
//       required this.controller,
//       required this.isNumberOnly,
//       this.maxNumberLength,
//       this.maxLines})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       keyboardType:
//           isNumberOnly == true ? TextInputType.number : TextInputType.text,
//       decoration: InputDecoration(
//         hintText: hintText,
//         // filled: true,
//         // fillColor: Colors.grey[200],
//         // border: OutlineInputBorder(
//         //   borderRadius: BorderRadius.circular(8),
//         //   borderSide: BorderSide.none,
//         // ),
//       ),
//       validator: (val) {
//         if (val == null || val.isEmpty || val.length < maxNumberLength!) {
//           return 'Enter your $hintText';
//         }
//         return null;
//       },
//       maxLines: maxLines,
//       inputFormatters: [
//         isNumberOnly == true
//             ? FilteringTextInputFormatter.digitsOnly
//             : FilteringTextInputFormatter.singleLineFormatter,
//       ],
//       cursorColor: Theme.of(context).primaryColor,
//     );
//   }
// }

class CustomTextFormField extends TextFormField {
  CustomTextFormField({
    required BuildContext context,
    Key? key,
    required bool isNumberOnly,
    required TextEditingController controller,
    String? hintText,
    IconData? icon,
  }) : super(
          key: key,
          controller: controller,
          keyboardType:
              isNumberOnly == true ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: hintText ?? 'Default_Hint',
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            prefixIcon: icon?.codePoint != null ? Icon(icon) : null,
          ),
          inputFormatters: [
            isNumberOnly == true
                ? FilteringTextInputFormatter.digitsOnly
                : FilteringTextInputFormatter.singleLineFormatter
          ],
          cursorColor: Theme.of(context).primaryColor,
        );
}


// class CustomTextField extends TextFormField {
//   final String label;
//   final TextEditingController controller;
//   final IconData? icon;
//   final bool isNumberOnly;
//   final int maxLines;

//   CustomTextField(
//     this.maxLines, {
//     super.key,
//     required this.label,
//     required this.controller,
//     this.icon,
//     required this.isNumberOnly,
//   });

//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         border: Border.all(
//           color: Theme.of(context).primaryColor,
//           width: 2.0,
//         ),
//       ),
//       child: TextFormField(
//         controller: controller,
//         keyboardType:
//             isNumberOnly == true ? TextInputType.number : TextInputType.text,
//         decoration: InputDecoration(
//           labelText: label,
//           hintText: label,
//           filled: true,
//           fillColor: Colors.grey[200],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide.none,
//           ),
//           icon: Icon(icon),
//         ),
//         maxLines: maxLines,
//         inputFormatters: [
//           isNumberOnly == true
//               ? FilteringTextInputFormatter.digitsOnly
//               : FilteringTextInputFormatter.singleLineFormatter
//         ],
//       ),
//     );
//   }
// }

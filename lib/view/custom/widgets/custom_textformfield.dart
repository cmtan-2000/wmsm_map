import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends TextFormField {
  CustomTextFormField({
    Function()? onTap,
    bool? readOnly,
    required BuildContext context,
    Key? key,
    required bool isNumberOnly,
    required TextEditingController controller,
    String? hintText,
    labelText,
    IconData? icon,
    Widget? suffixicon,
    int? maxLength,
  }) : super(
          key: key,
          maxLength: maxLength,
          controller: controller,
          onTap: onTap,
          readOnly: readOnly ?? false,
          keyboardType:
              isNumberOnly == true ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            // hintText: hintText ?? 'Default_Hint',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            labelText: labelText,
            hintText: hintText,
            filled: true,
            fillColor: const Color.fromARGB(255, 250, 250, 250),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black),
            ),
            prefixIcon: icon?.codePoint != null ? Icon(icon) : null,
            suffixIcon: suffixicon,
          ),
          inputFormatters: [
            isNumberOnly == true
                ? FilteringTextInputFormatter.digitsOnly
                : FilteringTextInputFormatter.singleLineFormatter
          ],
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter ' + labelText;
            }
            return null;
          },
          cursorColor: Theme.of(context).primaryColor,
        );
}

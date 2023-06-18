import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends TextFormField {
  CustomTextFormField({
    Function()? onTap,
    bool? readOnly,
    required BuildContext context,
    Key? key,
    bool? isNumberOnly,
    required TextEditingController controller,
    String? hintText,
    labelText,
    IconData? icon,
    Widget? suffixicon,
    int? maxLength,
    TextInputType? keyboardType,
    validator,
    bool? obscureText,
    suffix,
    TextInputAction? textInputAction,
    String? prefixText,
    Function(String)? onChanged,
  }) : super(
          key: key,
          autofocus: true,
          autocorrect: true,
          textInputAction: textInputAction,
          maxLength: maxLength,
          controller: controller,
          onTap: onTap,
          readOnly: readOnly ?? false,
          keyboardType: keyboardType ?? TextInputType.text,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            labelText: labelText,
            hintText: hintText,
            prefixText: prefixText,
            labelStyle: const TextStyle(color: Colors.blueGrey),
            filled: true,
            fillColor: const Color.fromARGB(255, 250, 250, 250),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black),
            ),
            prefixIcon: icon?.codePoint != null ? Icon(icon) : null,
            suffix: suffix,
            suffixIcon: suffixicon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.blueGrey,
              ),
            ),
          ),
          inputFormatters: [
            isNumberOnly == true
                ? FilteringTextInputFormatter.digitsOnly
                : FilteringTextInputFormatter.singleLineFormatter
          ],
          validator: validator ??
              (value) {
                if (value!.isEmpty) {
                  return "Please enter $labelText";
                }
                return null;
              },
          obscureText: obscureText ?? false,
          cursorColor: Theme.of(context).primaryColor,
        );
}

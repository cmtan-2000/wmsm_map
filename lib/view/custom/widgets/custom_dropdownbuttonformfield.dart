import 'package:flutter/material.dart';

class CustomDropdownButtonFormField extends DropdownButtonFormField {
  CustomDropdownButtonFormField({
    super.key,
    required labelText,
    required hintText,
    required String selectedValue,
    required List<dynamic> items,
    required onChanged,
  }) : super(
          value: selectedValue,
          items: items
              .map((value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            border: const OutlineInputBorder(

            ),
          ),
          validator: (value) {
            if (value == null) {
              return 'Please Select ' + labelText;
            }
            return null;
          },
        );
}

import 'package:flutter/material.dart';

class multiLineTextField extends StatelessWidget {
  const multiLineTextField(
      {super.key,
      required TextEditingController multiLineController,
      required this.hintText,
      required this.labelText})
      : _multiLineController = multiLineController;
  final TextEditingController _multiLineController;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: _multiLineController,
            minLines: 1,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              labelStyle: const TextStyle(color: Colors.blueGrey),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              filled: true,
              fillColor: const Color.fromARGB(255, 250, 250, 250),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.blueGrey,
                ),
              ),
            ),
            textInputAction: TextInputAction.newline,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your $labelText description";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

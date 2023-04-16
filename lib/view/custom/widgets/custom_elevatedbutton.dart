import 'package:flutter/material.dart';

class CustomElevatedButton extends ElevatedButton {
  const CustomElevatedButton({
    Key? key,
    required VoidCallback onPressed,
    required Widget child,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip? clipBehavior,
  }) : super(
          key: key,
          onPressed: onPressed,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior ?? Clip.none,
          child: child,
        );
}

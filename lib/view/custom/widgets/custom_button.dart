import 'package:flutter/material.dart';

class CustomTextButton extends TextButton {
  CustomTextButton({
    required BuildContext context,
    Key? key,
    required VoidCallback onPressed,
    String? text,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? foregroundColor,
    Size? minimumSize,
  }) : super(
          key: key,
          onPressed: onPressed,
          child: Text(
            text ?? 'Default',
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                backgroundColor ?? Colors.transparent),
            foregroundColor:
                MaterialStateProperty.all(foregroundColor ?? Colors.black),
            textStyle: MaterialStateProperty.all(textStyle ??
                const TextStyle(
                  fontSize: 16,
                )),
            minimumSize: MaterialStateProperty.all<Size>(
              minimumSize ?? const Size(100, 36),
            ),
          ),
        );
}

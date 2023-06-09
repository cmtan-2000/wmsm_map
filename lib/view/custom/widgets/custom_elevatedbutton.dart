import 'package:flutter/material.dart';

class CustomElevatedButton extends ElevatedButton {
  CustomElevatedButton({
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
          // child: LayoutBuilder(builder: (context, constraint) {
          //   return SizedBox(
          //     width: constraint.minWidth < 50 ? 100 : constraint.minWidth,
          //     height: constraint.minHeight < 50 ? 50 : constraint.minHeight,
          //     child: FittedBox(
          //       fit: BoxFit.scaleDown,
          //       child: child,
          //     ),
          //   );
          // }),
        );
}

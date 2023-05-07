import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomOutlinedButton extends OutlinedButton {
  late BuildContext context;

  CustomOutlinedButton({
    Key? key,
    required onPressed,
    required IconData? iconData,
    required String text,
    required bool disabled,
  }) : super(
          style: OutlinedButton.styleFrom(
            side: disabled
                ? const BorderSide(
                    width: 2,
                    color: Colors.grey,
                  )
                : const BorderSide(color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (iconData != null) Icon(iconData, color: Colors.black),
              if (iconData != null) const SizedBox(width: 5),
              if (text.isNotEmpty)
                disabled
                    ? Text(
                        text,
                        style: const TextStyle(color: Colors.grey),
                      )
                    : Text(
                        text,
                        style: const TextStyle(color: Colors.black),
                      ),
            ],
          ),
          onPressed: onPressed,
          key: key,
        );
}

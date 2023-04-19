import 'package:flutter/material.dart';

class CustomOutlinedButton extends OutlinedButton {
  late BuildContext context;

  CustomOutlinedButton({
    Key? key,
    required VoidCallback onPressed,
    required IconData? iconData,
    required String text,
    required context,
  }) : super(
          key: key,
          onPressed: onPressed,
          style: ButtonStyle(
            // elevation: MaterialStateProperty.all<double>(8),
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (iconData != null) Icon(iconData),
              if (iconData != null) const SizedBox(width: 5),
              if (text != null)
                Text(
                  text,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
            ],
          ),
        );
}

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class Awesome {
  static SnackBar snackbar(
      String title, String message, ContentType contentType) {
    return SnackBar(
      
      elevation: 0,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );
  }

  static MaterialBanner materialBanner(
      String title, String message, ContentType contentType) {
    return MaterialBanner(
      elevation: 0,
      
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
        inMaterialBanner: true,
      ),
      actions: const [SizedBox.shrink()],
    );
  }
}

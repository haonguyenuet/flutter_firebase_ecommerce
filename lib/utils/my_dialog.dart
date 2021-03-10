import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog {
  static showInformation(
    BuildContext context, {
    String title = "Message for you",
    String? content,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: mPrimaryColor),
        ),
        content: Text(content!),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Close',
              style: TextStyle(color: mPrimaryColor),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  static showWating(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: 150,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  static Future<bool?> showConfirmation(
    BuildContext context, {
    String title = "Message for you",
    String confirmButtonText = "Yes",
    String? content,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: mPrimaryColor),
        ),
        content: Text(content!),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: mPrimaryColor),
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text(
              confirmButtonText,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(backgroundColor: mPrimaryColor),
          ),
        ],
      ),
    );
  }
}

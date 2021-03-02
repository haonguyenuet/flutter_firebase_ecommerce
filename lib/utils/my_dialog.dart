import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog {
  static showInformation(
    BuildContext context, {
    String title = "Message for you",
    String content,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: mPrimaryColor),
        ),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  static showWating(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Wating..."),
      ),
    );
  }

  static Future<bool> showConfirmation(
    BuildContext context, {
    String title = "Message for you",
    String confirmButtonText = "Yes",
    String content,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: mPrimaryColor),
        ),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text(confirmButtonText),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }
}

import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/translate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UtilDialog {
  static showInformation(
    BuildContext context, {
    String? title,
    String? content,
    Function()? onClose,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title == null
              ? Translate.of(context).translate("message_for_you")
              : title,
          style: TextStyle(color: COLOR_CONST.primaryColor),
        ),
        content: Text(content!),
        actions: <Widget>[
          TextButton(
            child: Text(
              Translate.of(context).translate("close"),
              style: TextStyle(color: COLOR_CONST.primaryColor),
            ),
            onPressed:
                onClose != null ? onClose : () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  static showWaiting(BuildContext context) {
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

  static hideWaiting(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<bool?> showConfirmation(
    BuildContext context, {
    String? title,
    required Widget content,
    String confirmButtonText = "Yes",
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          title == null
              ? Translate.of(context).translate("message_for_you")
              : title,
          style: TextStyle(color: COLOR_CONST.primaryColor),
        ),
        content: content,
        actions: <Widget>[
          TextButton(
            child: Text(
              Translate.of(context).translate("close"),
              style: TextStyle(color: COLOR_CONST.primaryColor),
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text(
              confirmButtonText,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context, true),
            style:
                TextButton.styleFrom(backgroundColor: COLOR_CONST.primaryColor),
          ),
        ],
      ),
    );
  }
}

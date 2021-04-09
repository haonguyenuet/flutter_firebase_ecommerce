import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
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
      builder: (context) {
        return AlertDialog(
          title: Text(
            title == null
                ? Translate.of(context).translate("message_for_you")
                : title,
            style: FONT_CONST.REGULAR_PRIMARY,
          ),
          content: Text(content!),
          actions: <Widget>[
            TextButton(
              child: Text(
                Translate.of(context).translate("close"),
                style: FONT_CONST.REGULAR_PRIMARY,
              ),
              onPressed:
                  onClose != null ? onClose : () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  static showWaiting(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 150,
            alignment: Alignment.center,
            child: Loading(),
          ),
        );
      },
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
      builder: (context) {
        return AlertDialog(
          title: Text(
            title == null
                ? Translate.of(context).translate("message_for_you")
                : title,
            style: FONT_CONST.REGULAR_PRIMARY,
          ),
          content: content,
          actions: <Widget>[
            TextButton(
              child: Text(
                Translate.of(context).translate("close"),
                style: FONT_CONST.REGULAR_PRIMARY,
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: Text(
                confirmButtonText,
                style: FONT_CONST.REGULAR_WHITE,
              ),
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(
                  backgroundColor: COLOR_CONST.primaryColor),
            ),
          ],
        );
      },
    );
  }
}

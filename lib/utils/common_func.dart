import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

/// Get image
Future<String> loadImage(dynamic imageURL) {
  return FirebaseStorage.instance.refFromURL(imageURL).getDownloadURL();
}

/// Show processing
void showProcessing(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(content),
            CircularProgressIndicator(backgroundColor: mPrimaryColor),
          ],
        ),
      ),
    );
}

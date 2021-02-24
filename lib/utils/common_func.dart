import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

String formatNumber(int number) {
  final tool = new NumberFormat("#,##0", "en_US");
  return tool.format(number);
}

String formatTimeStamp(Timestamp timestamp) {
  var format = new DateFormat.yMd().add_jm();
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
  return format.format(date);
}

/// Get image
Future<String> loadImage(dynamic imageURL) {
  return FirebaseStorage.instance.refFromURL(imageURL).getDownloadURL();
}

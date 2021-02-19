import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

String formatNumber(int number) {
  final tool = new NumberFormat("#,##0", "en_US");
  return tool.format(number);
}

Future<String> getProductImage({@required dynamic imageURL}) {
  return FirebaseStorage.instance.refFromURL(imageURL).getDownloadURL();
}

Future<String> getUserAvatar({@required UserModel user}) {
  return FirebaseStorage.instance.refFromURL(user.avatar).getDownloadURL();
}

String formatTimeStamp(Timestamp timestamp) {
  var format = new DateFormat.yMd().add_jm();
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
  return format.format(date);
}

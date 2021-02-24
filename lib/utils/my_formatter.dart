import 'package:cloud_firestore/cloud_firestore.dart';
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

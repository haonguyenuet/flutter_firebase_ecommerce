import 'package:e_commerce_app/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

String formatNumber(int number) {
  final tool = new NumberFormat("#,##0", "en_US");
  return tool.format(number);
}

Future<String> getProductImage({
  @required Product product,
  @required int index,
}) {
  return FirebaseStorage.instance
      .refFromURL(product.images[index])
      .getDownloadURL();
}

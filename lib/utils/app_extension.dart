import 'package:e_commerce_app/utils/utils.dart';

extension PriceParsing on int {
  String toPrice() {
    return "${UtilFormatter.formatNumber(this)}₫";
  }
}

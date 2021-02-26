import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: SpinKitCircle(color: mPrimaryColor));
  }
}

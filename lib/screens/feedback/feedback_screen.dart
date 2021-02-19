import 'package:e_commerce_app/screens/feedback/components/body.dart';
import 'package:e_commerce_app/screens/feedback/components/feedback_bottom_sheet.dart';
import 'package:e_commerce_app/size_config.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  static String routeName = "/feedback";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Đánh giá sản phẩm"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _settingModalBottomSheet(context),
          )
        ],
      ),
      body: Body(),
    );
  }
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return FeedbackBottomSheet();
    },
  );
}

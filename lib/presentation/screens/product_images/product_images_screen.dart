import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/data/entities/entites.dart';
import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/widgets/buttons/default_button.dart';
import 'package:e_commerce_app/utils/translate.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ProductImagesScreen extends StatefulWidget {
  final Product product;
  final int selectedIndex;

  const ProductImagesScreen({
    Key? key,
    required this.product,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  _ProductImagesScreenState createState() => _ProductImagesScreenState();
}

class _ProductImagesScreenState extends State<ProductImagesScreen> {
  late PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.selectedIndex);
    currentPage = widget.selectedIndex;
    super.initState();
  }

  void onPageChanged(index) => setState(() => currentPage = index);

  void onSave() async {
    var response = await Dio().get(
      widget.product.images[currentPage],
      options: Options(responseType: ResponseType.bytes),
    );
    await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
      name: widget.product.name,
    );

    print("save success");

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            color: Colors.black,
            child: PageView.builder(
              controller: pageController,
              itemCount: widget.product.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  onLongPress: _openSaveBottomSheet,
                  child: Image.network(widget.product.images[index]),
                );
              },
              onPageChanged: onPageChanged,
            ),
          ),

          /// dots
          Positioned(
            bottom: SizeConfig.defaultSize * 3,
            width: SizeConfig.screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  widget.product.images.length, (index) => _buildDot(index)),
            ),
          ),
        ],
      ),
    );
  }

  _buildDot(int index) {
    return AnimatedContainer(
      duration: mAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: SizeConfig.defaultSize,
      width: SizeConfig.defaultSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            currentPage == index ? COLOR_CONST.primaryColor : Color(0xFFD8D8D8),
      ),
    );
  }

  _openSaveBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DefaultButton(
          onPressed: onSave,
          backgroundColor: Colors.white,
          child: Text(
            Translate.of(context).translate("save"),
            style: FONT_CONST.BOLD_DEFAULT_18,
          ),
        );
      },
    );
  }
}

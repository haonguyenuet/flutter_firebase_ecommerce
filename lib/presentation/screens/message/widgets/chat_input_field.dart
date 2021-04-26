import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/message/bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    Key? key,
  }) : super(key: key);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController messageController = TextEditingController();
  List<Asset> images = <Asset>[];
  String error = 'No Error Dectected';

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (images.isNotEmpty) {
      BlocProvider.of<MessageBloc>(context).add(SendImageMessage(
        images: images,
        text: messageController.text,
      ));
    } else if (messageController.text.isNotEmpty) {
      BlocProvider.of<MessageBloc>(context).add(SendTextMessage(
        text: messageController.text,
      ));
    }
    // Clear input
    setState(() {
      messageController.clear();
      images = [];
    });
  }

  void selectImage() async {
    List<Asset> resultList = <Asset>[];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#3ac5c9",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultPadding,
        vertical: SizeConfig.defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: COLOR_CONST.cardShadowColor.withOpacity(0.5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultPadding,
              ),
              decoration: BoxDecoration(
                color: COLOR_CONST.primaryColor.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (images.isNotEmpty) _buildImages(),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          textInputAction: TextInputAction.send,
                          onEditingComplete: sendMessage,
                          decoration: InputDecoration(
                            hintText: "Type message",
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.image),
                        onPressed: selectImage,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: SizeConfig.defaultPadding),
          IconButton(
            icon: Icon(Icons.send, color: COLOR_CONST.primaryColor),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }

  _buildImages() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.defaultSize,
              right: SizeConfig.defaultSize,
            ),
            child: Stack(
              children: [
                AssetThumb(asset: asset, width: 100, height: 100),
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        images.removeAt(index);
                      });
                    },
                    child: Icon(Icons.close, color: COLOR_CONST.borderColor),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

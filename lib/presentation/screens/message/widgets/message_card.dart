import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/presentation/common_blocs/common_bloc.dart';
import 'package:e_commerce_app/presentation/common_blocs/profile/bloc.dart';
import 'package:e_commerce_app/utils/formatter.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({Key? key, required this.message}) : super(key: key);

  final MessageModel message;

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    bool isSender = false;
    ProfileState profileState = CommonBloc.profileBloc.state;
    if (profileState is ProfileLoaded &&
        profileState.loggedUser.id == widget.message.senderId) {
      isSender = true;
    }

    Widget contentWidget = Container();

    if (widget.message is TextMessageModel) {
      contentWidget = _buildTextMessage(
        widget.message as TextMessageModel,
        isSender,
      );
    } else if (widget.message is ImageMessageModel) {
      contentWidget = _buildImageMessage(
        widget.message as ImageMessageModel,
        isSender,
      );
    } else {
      contentWidget = _buildTextMessage(
        widget.message as TextMessageModel,
        isSender,
      );
    }

    return GestureDetector(
      onTap: () {},
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(
            left: isSender ? SizeConfig.defaultSize * 15 : 0,
            right: isSender ? 0 : SizeConfig.defaultSize * 15,
            top: SizeConfig.defaultSize,
          ),
          padding: EdgeInsets.all(SizeConfig.defaultPadding),
          decoration: BoxDecoration(
            color: COLOR_CONST.primaryColor.withOpacity(isSender ? 1 : 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              contentWidget,
              const SizedBox(height: 5),
              Text(
                UtilFormatter.formatTimeStamp(widget.message.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  color: isSender ? Colors.white : COLOR_CONST.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTextMessage(TextMessageModel message, bool isSender) {
    return Text(
      message.text,
      style: isSender
          ? FONT_CONST.REGULAR_WHITE_16
          : FONT_CONST.REGULAR_DEFAULT_16,
      maxLines: null,
      textWidthBasis: TextWidthBasis.longestLine,
    );
  }

  _buildImageMessage(ImageMessageModel message, bool isSender) {
    var textPart = message.text!.isNotEmpty
        ? Text(
            message.text!,
            style: isSender
                ? FONT_CONST.REGULAR_WHITE_16
                : FONT_CONST.REGULAR_DEFAULT_16,
            maxLines: null,
            textWidthBasis: TextWidthBasis.longestLine,
          )
        : Container();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textPart,
        const SizedBox(height: 5),
        Wrap(
          children: List.generate(message.images.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.DETAIL_IMAGE,
                  arguments: message.images[index],
                );
              },
              child: Image.network(
                message.images[index],
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            );
          }),
        )
      ],
    );
  }
}

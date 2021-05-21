import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/message/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/screens/message/widgets/chat_input_field.dart';
import 'package:e_commerce_app/presentation/screens/message/widgets/list_messages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageBloc()..add(LoadMessages()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: ListMessages()),
              ChatInputField(),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(backgroundImage: AssetImage(IMAGE_CONST.DEFAULT_AVATAR)),
          SizedBox(width: SizeConfig.defaultPadding),
          Text(
            "Peachy",
            style: FONT_CONST.BOLD_DEFAULT_18,
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () async {
            await _makePhoneCall("0967438901");
          },
        ),
        SizedBox(width: SizeConfig.defaultPadding / 2),
      ],
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    if (await canLaunch("tel:$phoneNumber")) {
      await launch("tel:$phoneNumber");
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}

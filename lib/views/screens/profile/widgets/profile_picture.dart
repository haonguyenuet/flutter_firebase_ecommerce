import 'dart:io';

import 'package:e_commerce_app/business_logic/blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatelessWidget {
  ProfilePic({
    Key? key,
    required this.loggedUser,
  }) : super(key: key);

  final UserModel loggedUser;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: CircleAvatar(
            backgroundImage: loggedUser.avatar!.isNotEmpty
                    ? NetworkImage(loggedUser.avatar!)
                    : AssetImage("assets/images/default_avatar.jpg")
                as ImageProvider<Object>,
          ),
        ),
        Positioned(
          right: -10,
          bottom: 0,
          child: SizedBox(
            height: 46,
            width: 46,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFF5F6F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
              ),
              onPressed: () => uploadAvatar(context),
              child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
            ),
          ),
        )
      ],
    );
  }

  void uploadAvatar(BuildContext context) async {
    ImagePicker _imagePicker = ImagePicker();
    PickedFile file = await (_imagePicker.getImage(source: ImageSource.gallery)
        as Future<PickedFile>);
    File imageFile = File(file.path);
    BlocProvider.of<ProfileBloc>(context).add(UploadAvatar(imageFile));
  }
}

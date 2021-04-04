import 'dart:io';
import 'package:e_commerce_app/business_logic/common_blocs/profile/bloc.dart';
import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/constants/image_constant.dart';
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
      clipBehavior: Clip.none,
      children: [
        Container(
          height: SizeConfig.defaultSize * 15,
          width: SizeConfig.defaultSize * 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: CircleAvatar(
            backgroundImage: loggedUser.avatar.isNotEmpty
                ? NetworkImage(loggedUser.avatar)
                : AssetImage(IMAGE_CONST.DEFAULT_AVATAR)
                    as ImageProvider<Object>,
          ),
        ),
        Positioned(
          right: SizeConfig.defaultSize,
          bottom: 0,
          child: SizedBox(
            height: SizeConfig.defaultSize * 4,
            width: SizeConfig.defaultSize * 4,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFF5F6F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
              ),
              onPressed: () => uploadAvatar(context),
              child: SvgPicture.asset(ICON_CONST.CAMERA),
            ),
          ),
        )
      ],
    );
  }

  void uploadAvatar(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    File imageFile;
    final file = await picker.getImage(source: ImageSource.gallery);
    if (file != null) {
      imageFile = File(file.path);
      BlocProvider.of<ProfileBloc>(context).add(UploadAvatar(imageFile));
    }
  }
}

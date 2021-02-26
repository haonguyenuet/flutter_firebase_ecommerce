import 'dart:io';

import 'package:e_commerce_app/business_logic/entities/user.dart';
import 'package:e_commerce_app/business_logic/repository/storage_repo.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatelessWidget {
  ProfilePic({
    Key key,
    @required this.loggedUser,
  }) : super(key: key);

  final UserModel loggedUser;
  final ImagePicker _imagePicker = ImagePicker();
  final StorageRepository _storageRepository = StorageRepository();

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: CircleAvatar(
            backgroundImage: loggedUser.avatar.isNotEmpty
                ? NetworkImage(loggedUser.avatar)
                : AssetImage("assets/images/default_avatar.jpg"),
          ),
        ),
        Positioned(
          right: -10,
          bottom: 0,
          child: SizedBox(
            height: 46,
            width: 46,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: BorderSide(color: Colors.white),
              ),
              color: Color(0xFFF5F6F9),
              onPressed: () => uploadAvatar(context),
              child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
            ),
          ),
        )
      ],
    );
  }

  void uploadAvatar(BuildContext context) async {
    PickedFile file = await _imagePicker.getImage(source: ImageSource.gallery);
    File imageFile = File(file.path);
    String url = await _storageRepository.uploadImage(
      "users/profile/${loggedUser.id}",
      imageFile,
    );

    /// Clone a user model with new data
    UserModel updatedUser = loggedUser.cloneWith(avatar: url);
  }
}

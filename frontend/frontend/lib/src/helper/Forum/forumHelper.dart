import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:frontend/src/widgets/Forum/forumCreateThreadCard.dart';
import 'package:frontend/src/widgets/Forum/forumEditForumThreadCard.dart';
import 'package:image_picker/image_picker.dart';

Widget ForumCreateIsImageWidget() {
  try {
    return Image.file(
      ForumCreateImageFile!,
      height: 250,
      width: 350,
      fit: BoxFit.cover,
    );
  } catch (Exception) {
    return SizedBox.shrink();
  }
}

ForumCreateGetFromGallery() async {
  PickedFile? pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    ForumCreateImageFile = File(pickedFile.path);
    final bytes = Io.File(pickedFile.path).readAsBytesSync();
    ForumCreateImg64 = base64Encode(bytes);
  }
}

Widget editForumThreadIsImageWidget(String ImageF) {
  try {
    if (ImageF.isNotEmpty && editForumThreadImageFile == null) {
      editForumThreadInputImage = ImageF;
      //if the image in the DB is not Empty and the current selected file is null display as below
      return Image.memory(
        Base64Decoder().convert(ImageF),
        fit: BoxFit.fill,
      );
    } else {
      return Image.file(
        editForumThreadImageFile!,
        height: 250,
        width: 350,
        fit: BoxFit.cover,
      );
    }
  } catch (Exception) {
    return SizedBox.shrink();
  }
}

editForumThreadGetFromGallery() async {
  PickedFile? pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    editForumThreadImageFile = File(pickedFile.path);

    final bytes = Io.File(pickedFile.path).readAsBytesSync();

    editForumThreadImg64 = base64Encode(bytes);
  }
}

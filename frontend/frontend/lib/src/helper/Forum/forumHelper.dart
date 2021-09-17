import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:frontend/src/widgets/Forum/forumCreateThreadCard.dart';
import 'package:frontend/src/widgets/Forum/forumEditForumThreadCard.dart';
import 'package:image_picker/image_picker.dart';

//function ot create and return image widget
Widget forumCreateIsImageWidget() {
  try {
    return Image.file(
      forumCreateImageFile!,
      height: 250,
      width: 350,
      fit: BoxFit.cover,
    );
  } catch (Exception) {
    return SizedBox.shrink();
  }
}

//function to fetch image from device gallery and encode image in base64
forumCreateGetFromGallery() async {
  PickedFile? pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    forumCreateImageFile = File(pickedFile.path);
    final bytes = Io.File(pickedFile.path).readAsBytesSync();
    forumCreateImg64 = base64Encode(bytes);
  }
}

//decode, create and return widget from base64 image file
Widget editForumThreadIsImageWidget(String imageF) {
  try {
    if (imageF.isNotEmpty && editForumThreadImageFile == null) {
      editForumThreadInputImage = imageF;
      return Image.memory(
        Base64Decoder().convert(imageF),
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

// function to encode image to base 64 when picked from gallery
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

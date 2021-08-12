import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:flutter/cupertino.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardCreateCard.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardEditCard.dart';
import 'package:image_picker/image_picker.dart';

Widget noticeboardCreateImageWidget() {
  try {
    return Image.file(
      noticeboardCreateImageFile!,
      height: 250,
      width: 350,
      fit: BoxFit.cover,
    );
  } catch (Exception) {
    return SizedBox.shrink();
  }
}

noticeboardCreateGetFromGallery() async {
  PickedFile? pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    noticeboardCreateImageFile = File(pickedFile.path);

    final bytes = Io.File(pickedFile.path).readAsBytesSync();

    noticeboardCreateImg64 = base64Encode(bytes);
  }
}

Widget noticeboardEditIsImageWidget(String ImageF) {
  try {
    if (ImageF.isNotEmpty && noticeboardEditImageFile == null) {
      noticeboardEditInputImage = ImageF;
      //if the image in the DB is not Empty and the current selected file is null display as below
      return Image.memory(
        Base64Decoder().convert(ImageF),
        fit: BoxFit.fill,
      );
    } else {
      return Image.file(
        noticeboardEditImageFile!,
        height: 250,
        width: 350,
        fit: BoxFit.cover,
      );
    }
  } catch (Exception) {
    return SizedBox.shrink();
  }
}

noticeboardEditGetFromGallery() async {
  PickedFile? pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    noticeboardEditImageFile = File(pickedFile.path);

    final bytes = Io.File(pickedFile.path).readAsBytesSync();

    noticeboardEditImg64 = base64Encode(bytes);
  }
}

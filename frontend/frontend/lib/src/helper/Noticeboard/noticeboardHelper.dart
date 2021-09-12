import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardCreateCard.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardEditCard.dart';
import 'package:image_picker/image_picker.dart';

Widget noticeboardCreateImageWidget(File? ImageFile) {
  try {
    return Image.file(
      ImageFile!,
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

Widget Reactions(BuildContext context) {
  return FlutterReactionButtonCheck(
    boxColor: Color.fromRGBO(33, 33, 33, 1),
    boxItemsSpacing: 7,
    boxPadding: EdgeInsets.only(top: 3, bottom: 3, left: 3),
    onReactionChanged: (reaction, index, isChecked) {
      print('reaction selected index: $index');
    },
    reactions: <Reaction>[
      Reaction(
        previewIcon: Icon(Icons.thumb_up_alt_rounded,
            size: 50, color: Color.fromRGBO(175, 255, 79, 1)),
        icon: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06, bottom: 10),
          child: Icon(Icons.thumb_up_alt_rounded,
              size: 25, color: Color.fromRGBO(175, 255, 79, 1)),
        ),
      ),
      Reaction(
        previewIcon:
            Icon(Icons.thumb_down_alt_rounded, size: 50, color: Colors.red),
        icon: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06, bottom: 10),
          child:
              Icon(Icons.thumb_down_alt_rounded, size: 25, color: Colors.red),
        ),
      ),
      Reaction(
        previewIcon: Icon(Icons.emoji_emotions,
            size: 50, color: Color.fromRGBO(175, 255, 79, 1)),
        icon: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06, bottom: 10),
          child: Icon(Icons.emoji_emotions,
              size: 25, color: Color.fromRGBO(175, 255, 79, 1)),
        ),
      ),
      Reaction(
        previewIcon: Icon(Icons.people,
            size: 50, color: Color.fromRGBO(175, 255, 79, 1)),
        icon: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06, bottom: 10),
          child: Icon(Icons.people,
              size: 25, color: Color.fromRGBO(175, 255, 79, 1)),
        ),
      ),
    ],
    initialReaction: Reaction(
      icon: Container(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.06,
            bottom: MediaQuery.of(context).size.width * 0.06,
            right: MediaQuery.of(context).size.width * 0.06,
            top: MediaQuery.of(context).size.width * 0.01),
        child: Icon(Icons.add_reaction_outlined,
            size: 25, color: Color.fromRGBO(175, 255, 79, 1)),
      ),
    ),
    selectedReaction: Reaction(
      icon: Container(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.06, bottom: 10),
        child: Icon((Icons.thumb_up_alt_rounded),
            size: 25, color: Color.fromRGBO(175, 255, 79, 1)),
      ),
    ),
  );
}
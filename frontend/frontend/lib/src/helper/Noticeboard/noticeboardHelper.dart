import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardCreateCard.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardEditCard.dart';
import 'package:image_picker/image_picker.dart';

//function to create image widget from imageFile
Widget noticeboardCreateImageWidget(File? imageFile) {
  try {
    return Image.file(
      imageFile!,
      height: 250,
      width: 350,
      fit: BoxFit.cover,
    );
  } catch (Exception) {
    return SizedBox.shrink();
  }
}

//function to select image file from device gallery and encode it to base 64
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

//function to decode image file from base 64 and return an image widget
Widget noticeboardEditIsImageWidget(String imageF) {
  try {
    if (imageF.isNotEmpty && noticeboardEditImageFile == null) {
      noticeboardEditInputImage = imageF;
      return Image.memory(
        Base64Decoder().convert(imageF),
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

//function to get image file from device gallery and encode to base64
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

//function to return container widget with reaction icons and functionality
Widget reactions(BuildContext context) {
  return FlutterReactionButtonCheck(
    boxColor: Color.fromRGBO(33, 33, 33, 1),
    boxItemsSpacing: 7,
    boxPadding: EdgeInsets.only(top: 3, bottom: 3, left: 3),
    onReactionChanged: (reaction, index, isChecked) {},
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

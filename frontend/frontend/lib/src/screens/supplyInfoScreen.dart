import 'package:flutter/material.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/google_sign_in.dart';
import 'package:frontend/src/widgets/profile_picture_widget.dart';
import 'package:provider/provider.dart';

import 'loginScreen.dart';

class InfoForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _infoForm();
  }
}

class _infoForm extends State<InfoForm> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  Widget build(context) => MaterialApp(
        home: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ProfilePicture(),
            ),
          ],
        ),
      );
}

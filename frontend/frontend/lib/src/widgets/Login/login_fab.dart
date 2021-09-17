import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginFab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginFab> {
  final utilModel = UtilModel();
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Color.fromRGBO(171, 255, 79, 1),
      onPressed: () {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.googleLogin();
      },
      child: Container(
        alignment: Alignment.center,
        child: SvgPicture.string(
          utilModel.svgRabbit,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

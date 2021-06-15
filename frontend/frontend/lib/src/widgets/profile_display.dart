import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _profileState();
  }
}

class _profileState extends State<ProfileDisplay> {
  Widget build(context) {
    return Scaffold(
      body: SvgPicture.string(''),
    );
  }
}

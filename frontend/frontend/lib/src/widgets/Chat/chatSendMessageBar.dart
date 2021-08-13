import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/helper/Chat/SignalRHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Chat/ChatRoomScreen.dart';

class ChatSendMessageBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _chatSendMessageBarState();
  }
}

class _chatSendMessageBarState extends State<ChatSendMessageBar> {
  final utilModel = UtilModel();
  final signalRHelper = SignalRHelper();
  @override
  Widget build(BuildContext context) => Container();
}

import 'package:flutter/material.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Chat/videoChatScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_svg/svg.dart';

class ChannelScreen extends StatefulWidget {
  @override
  _ChannelScreenState createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  UtilModel utilModel = UtilModel();
  final _channelName = TextEditingController();
  String check = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        elevation: 1,
        backgroundColor: utilModel.greyColor,
        title: Text(
          'Meeting Room',
          style: TextStyle(
            fontSize: 30,
            color: Color.fromRGBO(171, 255, 79, 1),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SvgPicture.string(
            utilModel.svg_background,
            fit: BoxFit.contain,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: TextFormField(
                        cursorColor: utilModel.greenColor,
                        controller: _channelName,
                        style: TextStyle(
                          color: utilModel.greenColor,
                          fontSize: 25,
                        ),
                        decoration: InputDecoration(
                          fillColor: utilModel.greenColor,
                          hoverColor: utilModel.greenColor,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: utilModel.greenColor,
                              width: 2,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: utilModel.greenColor,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: utilModel.greenColor,
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: utilModel.greenColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                          hintText: 'Channel Name...',
                          hintStyle: TextStyle(
                            color: utilModel.greenColor,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: utilModel.greyColor,
                          side: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.blue,
                            width: 2,
                          ),
                          primary: Colors.blue,
                        ),
                        onPressed: () => onJoin(
                          isBroadcaster: true,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'JOIN AS PRESENTOR  ',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                            Icon(
                              Icons.video_call_rounded,
                              size: 35,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 50, right: 50),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: utilModel.greyColor,
                          side: BorderSide(
                            style: BorderStyle.solid,
                            color: Color.fromRGBO(57, 219, 188, 1),
                            width: 2,
                          ),
                        ),
                        onPressed: () => onJoin(
                          isBroadcaster: false,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'JOIN AS VIEWER  ',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color.fromRGBO(57, 219, 188, 1),
                              ),
                            ),
                            Icon(
                              Icons.remove_red_eye,
                              size: 30,
                              color: Color.fromRGBO(57, 219, 188, 1),
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      check,
                      style: TextStyle(
                        color: utilModel.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> onJoin({required bool isBroadcaster}) async {
    await [Permission.camera, Permission.microphone].request();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoChatScreen(
          channelName: _channelName.text,
          isBroadcaster: isBroadcaster,
        ),
      ),
    );
  }
}

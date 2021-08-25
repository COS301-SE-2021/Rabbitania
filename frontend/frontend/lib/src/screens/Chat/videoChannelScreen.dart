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
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Center(
          child: Text(
            'Meeting Room',
            style: TextStyle(
              color: utilModel.greenColor,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
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
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.2,
                child: TextFormField(
                  controller: _channelName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Channel Name',
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.pink,
                ),
                onPressed: () => onJoin(
                  isBroadcaster: true,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Join as Presentor  ',
                      style: TextStyle(fontSize: 25),
                    ),
                    Icon(
                      Icons.live_tv,
                      size: 25,
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () => onJoin(
                  isBroadcaster: false,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Join as Viewer  ',
                      style: TextStyle(
                        fontSize: 25,
                        color: utilModel.greenColor,
                      ),
                    ),
                    Icon(
                      Icons.remove_red_eye,
                      size: 25,
                      color: utilModel.greenColor,
                    )
                  ],
                ),
              ),
              Text(
                check,
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> onJoin({required bool isBroadcaster}) async {
    await [Permission.camera, Permission.microphone].request();
    print("HELLLLLLLLLLLLLLLLLLLLLLLLLLLLOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
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

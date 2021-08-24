import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

const id = "e718dc1d125d4b59a3026ac5a600d65b";
const token =
    "006e718dc1d125d4b59a3026ac5a600d65bIABoegPMD3kOnH7OsjxPnuCdhx0NC9NuNrjh5qgwmSQPgwm+xr0AAAAAEACLgpZhRYkmYQEAAQBCiSZh";

class VideoChatScreen extends StatefulWidget {
  @override
  _VideoChatState createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChatScreen> {
  int? _remoteUid;
  late RtcEngine _engine;
  final utilModel = UtilModel();

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(id);
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print("local user $uid joined");
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.joinChannel(token, "div", null, 0);
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: utilModel.greyColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 1,
        title: const Text(
          'Video Call',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromRGBO(172, 255, 79, 1),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SvgPicture.string(
            utilModel.svg_background,
            fit: BoxFit.contain,
          ),
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: utilModel.greenColor,
                  width: 5,
                ),
              ),
              width: 180,
              height: 200,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  ),
                ),
                child: Center(
                  child: RtcLocalView.SurfaceView(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid!);
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: utilModel.greenColor,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
            ),
            Text(
              'WAITING FOR CONNECTION...',
              style: TextStyle(
                color: utilModel.greenColor,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }
}

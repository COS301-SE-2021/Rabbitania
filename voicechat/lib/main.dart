import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocal;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemote;

const appID = "e718dc1d125d4b59a3026ac5a600d65b";
const token = "006e718dc1d125d4b59a3026ac5a600d65bIABNx2T+6qzf3mKNpyQ36O+uprJB5Yf7ZjgtdTnler8kytzDPrsAAAAAEACcjToM52cZYQEAAQDnZxlh";

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _remoteUid;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(appID);

    //enable video and voice
    await _engine.enableVideo();
    await _engine.enableAudio();

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
    await _engine.joinChannel(token, "firstchannel", null, 0);
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 100,
              child: Center(
                child: RtcLocal.SurfaceView(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderLocalPreview(){
    return RtcLocal.SurfaceView();
  }
  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemote.SurfaceView(uid: _remoteUid!);
    } else {
      return Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
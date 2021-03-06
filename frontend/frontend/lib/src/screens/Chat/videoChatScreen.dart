import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:frontend/src/models/utilModel.dart';

class VideoChatScreen extends StatefulWidget {
  final String channelName;
  final bool isBroadcaster;
  final String appId;
  const VideoChatScreen(
      {Key? key,
      required this.channelName,
      required this.isBroadcaster,
      required this.appId})
      : super(key: key);

  @override
  _VideoChatState createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChatScreen> {
  final _users = <int>[];
  late RtcEngine _engine;
  bool muted = false;
  late int streamId;

  @override
  void dispose() {
    _users.clear();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    await _initAgoraRtcEngine();

    if (widget.isBroadcaster)
      streamId = (await _engine.createDataStream(false, false))!;

    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (channel, uid, elapsed) {
          setState(() {});
        },
        leaveChannel: (stats) {
          setState(() {
            _users.clear();
          });
        },
        userJoined: (uid, elapsed) {
          setState(() {
            _users.add(uid);
          });
        },
        userOffline: (uid, elapsed) {
          setState(() {
            _users.remove(uid);
          });
        },
        streamMessage: (_, __, message) {
          final String info = "here is the message $message";
        },
        streamMessageError: (_, __, error, ___, ____) {
          final String info = "here is the error $error";
        },
      ),
    );

    await _engine.joinChannel(null, widget.channelName, null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(widget.appId));
    await _engine.enableVideo();

    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      await _engine.setClientRole(ClientRole.Broadcaster);
    } else {
      await _engine.setClientRole(ClientRole.Audience);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            _broadcastView(),
            _toolbar(),
          ],
        ),
      ),
    );
  }

  Widget _toolbar() {
    UtilModel utilModel = UtilModel();

    return widget.isBroadcaster
        ? Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: _onToggleMute,
                  child: Icon(
                    muted ? Icons.mic_off : Icons.mic,
                    color: muted ? Colors.red : Colors.black,
                    size: 25.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: muted ? utilModel.greyColor : utilModel.greenColor,
                  padding: const EdgeInsets.all(12.0),
                ),
                RawMaterialButton(
                  onPressed: () => _onCallEnd(context),
                  child: Icon(
                    Icons.call_end,
                    color: Colors.black,
                    size: 35.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.redAccent,
                  padding: const EdgeInsets.all(15.0),
                ),
                RawMaterialButton(
                  onPressed: _onSwitchCamera,
                  child: Icon(
                    Icons.switch_camera,
                    color: Colors.black,
                    size: 25.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: utilModel.greenColor,
                  padding: const EdgeInsets.all(12.0),
                ),
              ],
            ),
          )
        : Container();
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.isBroadcaster) {
      list.add(
        RtcLocalView.SurfaceView(),
      );
    }
    _users.forEach(
      (int uid) => list.add(
        RtcRemoteView.SurfaceView(uid: uid),
      ),
    );
    return list;
  }

  /// Video view row wrapper
  Widget _expandedVideoView(List<Widget> views) {
    final wrappedViews = views
        .map<Widget>(
          (view) => Expanded(
            child: Container(child: view),
          ),
        )
        .toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _broadcastView() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView(
              [views[0]],
            )
          ],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView(
              [views[0]],
            ),
            _expandedVideoView(
              [views[1]],
            )
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView(
              views.sublist(0, 2),
            ),
            _expandedVideoView(
              views.sublist(2, 3),
            )
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView(
              views.sublist(0, 2),
            ),
            _expandedVideoView(
              views.sublist(2, 4),
            )
          ],
        ));
      default:
    }
    return Container();
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }
}

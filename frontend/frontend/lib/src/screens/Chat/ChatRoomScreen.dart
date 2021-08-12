import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/helper/Chat/SignalRHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/widgets/Chat/chatMessageReceiver.dart';
import 'package:frontend/src/widgets/Chat/chatMessageSender.dart';
import 'package:frontend/src/widgets/Chat/chatParticipantBar.dart';
import 'package:frontend/src/widgets/Chat/chatSendMessageBar.dart';
import 'package:signalr_core/signalr_core.dart';
import '../../../main.dart';
import '../../widgets/Chat/ChatModelPropertyWidgetBuilder.dart';
import '../../models/Chat/ChatPageModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage> {
  final serverURLEmulator = "https://10.0.2.2:5001/api/ChatHub";
  final serverURL = "https://localhost:5001/api/ChatHub";
  final userID = 0;
  HubConnection? _hubConnection;
  final utilModel = UtilModel();
  final signalRHelper = SignalRHelper();

  @override
  void initState() {
    super.initState();
    initSignalR();
    var user = 0;
    signalRHelper.initiateConnection(context).then((value) {
      signalRHelper.sendMessage('Bob', 'testMessage').then((response) {
        signalRHelper.getMessagesList().then((response) {
          var list = response;
          print(list[0].messageContent);
          print(list[0].associatedMessageSender);
          signalRHelper
              .sendMessage('James', 'test james message')
              .then((secondResponse) {
            signalRHelper.getMessagesList().then((newList) {
              print(list[1].messageContent);
              print(list[1].associatedMessageSender);
            });
          });
        });
      });
    });
  }

  void initSignalR() {
    _hubConnection = HubConnectionBuilder().withUrl(serverURLEmulator).build();
    _hubConnection!.onclose((exception) {
      print('Connection closed');
    });
    //_hubConnection!.on("ReceiveMessage", sendMessage());
  }

  sendMessage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: utilModel.greyColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: utilModel.greyColor,
        title: ChatParticipantBar(),
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 10, right: 10),
        child: Center(
          child: Column(
            children: <Widget>[
              ChatMessageSender(
                textSentValue: 'Hello world',
              ),
              ChatMessageReceiver(
                  textSentValue:
                      'Fuck off dhsjakldashdiuewhdsfjhkdsaldfhakdlsfhajkdfnmnx,cndaklsdfhaifquwerh'),
              ChatMessageSender(
                textSentValue: 'Hello ',
              ),
              ChatMessageSender(
                textSentValue:
                    'Hello world sghjakduisdhiqwhwqdhjskadhsajkdhsajkdhsjakldhqwuieyqwdhaskdhsadhasdqwyueqwdhasjk',
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: utilModel.greenColor,
      //   child: Icon(
      //     FontAwesomeIcons.paperPlane,
      //     color: Colors.black,
      //   ),
      //   onPressed: () async {
      //     _hubConnection!.state == HubConnectionState.disconnected
      //         ? await _hubConnection!.start()
      //         : await _hubConnection!.stop();
      //   },
      //   tooltip: 'Start/Stop',
      // ),
      bottomNavigationBar: Container(
        height: 180,
        child: Column(
          children: <Widget>[
            ChatSendMessageBar(),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
            ),
            ChatSendMessageBar(),
          ],
        ),
      ),
    );
  }

  connect() {
    if (_hubConnection!.state == HubConnectionState.connected)
      _hubConnection!.invoke("SendMessage", args: <Object>[userID, "Message"]);
    setState(() {});
  }
}

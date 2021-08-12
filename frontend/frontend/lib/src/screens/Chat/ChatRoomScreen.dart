import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/helper/Chat/SignalRHelper.dart';
import 'package:frontend/src/helper/Chat/chatHelper.dart';
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
  final chatHelper = ChatHelper();

  @override
  void initState() {
    super.initState();
    initSignalR();
    var user = 0;
    signalRHelper.initiateConnection(context).then((value) {
      signalRHelper.sendMessage('bob', 'testMessage').then((response) {
        signalRHelper.getMessagesList().then((response) {
          var list = response;
          print(list[0].messageContent);
          print(list[0].associatedMessageSender);
          signalRHelper
              .sendMessage('RuntimeTerrors', 'test james message')
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
              FutureBuilder(
                future: signalRHelper.getMessagesList(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  List<Widget> children = [];
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    if (snapshot.data.length == 0) {
                      children = [Text('You have no chat history')];
                    } else {
                      snapshot.data.forEach((current) {
                        if (current.messageType == 'Sender') {
                          children.add(
                            ChatMessageSender(
                                textSentValue: current.messageContent),
                          );
                        } else {
                          children.add(
                            ChatMessageReceiver(
                                textSentValue: current.messageContent),
                          );
                        }
                      });
                    }
                  } else if (snapshot.hasError) {
                    children = [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                    ];
                  } else {
                    children = [
                      Center(
                        child: Stack(children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: new BoxDecoration(
                              color: Color.fromRGBO(33, 33, 33, 1),
                            ),
                            child: Center(
                              widthFactor: 0.5,
                              heightFactor: 0.5,
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(171, 255, 79, 1),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ];
                  }
                  return Column(
                    children: [
                      ListView(shrinkWrap: true, children: children),
                    ],
                  );
                },
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
        child: ChatSendMessageBar(),
      ),
    );
  }

  connect() {
    if (_hubConnection!.state == HubConnectionState.connected)
      _hubConnection!.invoke("SendMessage", args: <Object>[userID, "Message"]);
    setState(() {});
  }
}

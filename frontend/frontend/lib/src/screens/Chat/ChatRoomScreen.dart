import 'package:signalr_core/signalr_core.dart';

import '../../../main.dart';
import '../../widgets/Chat/ChatModelPropertyWidgetBuilder.dart';
import '../../models/Chat/ChatPageModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

class ChatPageState extends State<ChatPage> {
  final serverURLEmulator = "https://10.0.2.2:5001/api/ChatHub";
  final serverURL = "https://localhost:5001/api/ChatHub";
  final userID = 0;
  HubConnection? _hubConnection;

  @override
  void initState() {
    super.initState();
    initSignalR();
    var user = 0;
  }

  void initSignalR() {
    _hubConnection = HubConnectionBuilder().withUrl(serverURLEmulator).build();
    _hubConnection!.onclose((exception) {
      print('Connection closed');
    });
    _hubConnection!.on("ReceiveMessage", sendMessage());
  }

  sendMessage() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Center(
        child: Column(

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          _hubConnection!.state == HubConnectionState.disconnected ?
              await _hubConnection!.start()
              :
              await _hubConnection!.stop();
        },
        tooltip: 'Start/Stop',
      ),
    );
  }

  connect() {
    if (_hubConnection!.state == HubConnectionState.connected)
      _hubConnection!.invoke("SendMessage", args:<Object>[
        userID,
        "Message"
      ]);
    setState(() {

    });
  }
}



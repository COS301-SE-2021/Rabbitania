import 'package:flutter/cupertino.dart';
import 'package:frontend/src/helper/Chat/chatHelper.dart';
import 'package:frontend/src/models/Chat/ChatMessageModel.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRHelper {
  final chatHelper = ChatHelper();
  static HubConnection connection = HubConnectionBuilder()
      .withUrl(
          //change this for deployment
          "https://10.0.2.2:5001/api/ChatHub",
          HttpConnectionOptions(
              //logging: (level, message) => print(message),
              ))
      .build();

  initiateConnection(BuildContext context) async {
    await connection.start();
    print("Connection initiated");
    //send 'ReceiveMessage' to server to get all chats and associated recipients
    connection.on("ReceiveMessage", (arguments) {
      //make and add ChatMessageModel to list
      String messageType = chatHelper.determineMessageType(arguments![0]);
      chatHelper.updateMessagesList(
        ChatMessageModel(
          messageType,
          arguments[0],
          arguments[1],
        ),
      );
      // print('receiver ' + arguments![0]);
      // print('message ' + arguments[1]);
    });
    var list = await chatHelper.getMessages();
    if (list.length > 0) {
      print(list[0].messageType +
          ' ' +
          list[0].messageContent +
          ' ' +
          list[0].associatedMessageSender);
    }
  }

  //method for adding message and recipient ot signalR
  sendMessage(recipient, message) async {
    await connection.invoke('SendMessage', args: [recipient, message]);
  }

  Future<List<ChatMessageModel>> getMessagesList() {
    return this.chatHelper.getMessages();
  }

  closeConnection(BuildContext context) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.stop();
      print("Connection Ended");
    }
  }
}

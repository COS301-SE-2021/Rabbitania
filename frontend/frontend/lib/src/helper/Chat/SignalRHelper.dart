import 'package:flutter/cupertino.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRHelper {
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
    connection.on("ReceiveMessage", (arguments) {
      print(arguments);
      //TODO: What needs to be done
    });
  }

  sendMessage(recipient, message) async {
    await connection.invoke('SendMessage', args: [recipient, message]);
  }

  closeConnection(BuildContext context) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.stop();
      print("Connection Ended");
    }
  }
}

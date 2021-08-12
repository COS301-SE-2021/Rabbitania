import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/src/models/Chat/ChatMessageModel.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/widgets/Chat/chatMessageReceiver.dart';
import 'package:frontend/src/widgets/Chat/chatMessageSender.dart';

class ChatHelper {
  //store message models used for creating message items in chatScreen
  List<ChatMessageModel> messages = [];
  //function for adding message obj to list
  void updateMessagesList(ChatMessageModel newMessage) {
    this.messages.add(newMessage);
  }

  //method for returning all messages as a list
  Future<List<ChatMessageModel>> getMessages() async {
    return this.messages;
  }

  String determineMessageType(username) {
    var thisUserName = FirebaseAuth.instance.currentUser!.displayName;
    if (thisUserName == username) {
      return 'Sender';
    } else {
      return 'Receiver';
    }
  }
}

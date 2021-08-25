import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:frontend/src/models/Chat/ChatMessageModel.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/Chat/ChatUserModel.dart';
import 'package:frontend/src/widgets/Chat/chatMessageReceiver.dart';
import 'package:frontend/src/widgets/Chat/chatMessageSender.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ChatHelper {
  List<ChatUserModel> selectedUsers = [];
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

  //function to determine what messages are sent from you or to you
  String determineMessageType(username) {
    var thisUserName = FirebaseAuth.instance.currentUser!.displayName;
    if (thisUserName == username) {
      return 'Sender';
    } else {
      return 'Receiver';
    }
  }

  //add selected user to list of selected users
  void addSelectedUser(ChatUserModel chatUser) {
    this.selectedUsers.add(chatUser);
  }

  String decryptData(encrypted, key) {
    String plainText = encrypted.toString();
    var k = encrypt.Key.fromUtf8(key);
    var iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(k));

    final eKey = encrypter.encrypt(plainText, iv: iv);

    return eKey.toString();
  }
}

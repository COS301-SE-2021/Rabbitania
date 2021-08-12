import 'package:frontend/src/models/Chat/ChatMessageModel.dart';

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
}

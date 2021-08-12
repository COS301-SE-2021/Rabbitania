class ChatMessageModel {
  //type must be send or receive
  final String messageType;
  final String messageContent;
  ChatMessageModel({
    required this.messageType,
    required this.messageContent,
  });
}

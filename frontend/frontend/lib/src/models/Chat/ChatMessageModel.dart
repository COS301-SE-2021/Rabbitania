class ChatMessageModel {
  //type must be send or receive
  final String messageType;
  final String messageContent;
  final String associatedMessageSender;
  ChatMessageModel(
    this.messageType,
    this.associatedMessageSender,
    this.messageContent,
  );
}

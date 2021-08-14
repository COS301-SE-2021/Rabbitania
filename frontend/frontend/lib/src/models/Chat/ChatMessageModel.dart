class ChatMessageModel {
  //type must be send or receive
  final uid;
  final message;
  final dateCreated;
  ChatMessageModel({this.uid, this.message, this.dateCreated});

  ChatMessageModel fromJson(Map<String, dynamic> json) => ChatMessageModel(
      uid: json['uid'],
      message: json['message'],
      dateCreated: json['dateCreated']);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'message': message,
        'dateCreated': dateCreated,
      };
}

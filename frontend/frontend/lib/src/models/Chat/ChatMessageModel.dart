//model used to model a direct message object
class ChatMessageModel {
  final uid;
  final toUid;
  final message;
  final dateCreated;
  ChatMessageModel({this.uid, this.toUid, this.message, this.dateCreated});

  ChatMessageModel fromJson(Map<String, dynamic> json) => ChatMessageModel(
      uid: json['uid'],
      toUid: json['toUid'],
      message: json['message'],
      dateCreated: json['dateCreated']);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'toUid': toUid,
        'message': message,
        'dateCreated': dateCreated,
      };
}

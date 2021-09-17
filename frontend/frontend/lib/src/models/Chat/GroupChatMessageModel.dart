//model used to model a group chat message for group chat message room
class GroupChatMessageModel {
  final uid;
  final message;
  final dateCreated;
  GroupChatMessageModel({this.uid, this.message, this.dateCreated});

  GroupChatMessageModel fromJson(Map<String, dynamic> json) =>
      GroupChatMessageModel(
          uid: json['uid'],
          message: json['message'],
          dateCreated: json['dateCreated']);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'message': message,
        'dateCreated': dateCreated,
      };
}

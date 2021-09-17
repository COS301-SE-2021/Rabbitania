//model used to model a group chat room object
class GroupChatFirestoreModel {
  final avatar;
  final participants;
  GroupChatFirestoreModel({this.participants, this.avatar});

  GroupChatFirestoreModel fromJson(Map<String, dynamic> json) =>
      GroupChatFirestoreModel(
          participants: json['participants'], avatar: json['avatar']);

  Map<String, dynamic> toJson() => {
        'participants': participants,
        'avatar': avatar,
      };
}

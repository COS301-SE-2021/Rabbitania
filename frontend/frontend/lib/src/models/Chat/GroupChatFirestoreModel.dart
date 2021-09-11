//each group chat has a avatar and list of participants when being created
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

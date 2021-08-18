class ChatFirestoreUserModel {
  final uid;
  final email;
  final displayName;
  final avatar;
  ChatFirestoreUserModel({this.uid, this.email, this.displayName, this.avatar});

  ChatFirestoreUserModel fromJson(Map<String, dynamic> json) =>
      ChatFirestoreUserModel(
          uid: json['uid'],
          email: json['email'],
          displayName: json['displayName'],
          avatar: json['avatar']);

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'displayName': displayName,
        'avatar': avatar,
      };
}

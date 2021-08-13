import 'package:flutter/cupertino.dart';
import 'package:frontend/src/models/userProfile_model.dart';
import 'package:frontend/src/models/util_model.dart';

class ChatHome extends StatefulWidget {
  createState() {
    return _ChatHome();
  }
}

late Future<List<UserProfileModel>> futureUsers;

class _ChatHome extends State<ChatHome> {
  final util = new UtilModel();
  void initState() {
    super.initState();
    // futureUsers = fetchUserProfiles();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

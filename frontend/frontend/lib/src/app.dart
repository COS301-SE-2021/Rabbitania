import 'package:flutter/material.dart';
import 'package:frontend/src/screens/noticeboardScreen.dart';
import './widgets/expandable_button_widget.dart';
import './screens/loginScreen.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  var profileName = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NoticeBoard(),
      ),
    );
  }
}

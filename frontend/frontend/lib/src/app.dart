import 'package:flutter/material.dart';
import 'package:frontend/src/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'screens/Login/loginScreen.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        home: Login(),
      ),
    );
  }
}

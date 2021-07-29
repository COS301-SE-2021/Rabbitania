import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/provider/google_sign_in.dart';
import 'package:frontend/src/screens/Booking/bookingHomeScreen.dart';
import 'package:frontend/src/screens/googleAuthTest.dart';
import 'package:frontend/src/screens/noticeboardScreen.dart';
import 'package:frontend/src/screens/supplyInfoScreen.dart';
import 'package:frontend/src/screens/userProfileScreen.dart';
import 'package:provider/provider.dart';
import './widgets/expandable_button_widget.dart';
import './screens/loginScreen.dart';

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
        //home: Login(),
        home: BookingScreen(),
      ),
    );
  }
}

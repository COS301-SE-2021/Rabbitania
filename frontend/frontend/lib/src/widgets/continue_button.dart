import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/screens/noticeboardScreen.dart';
import 'package:frontend/src/screens/supplyInfoScreen.dart';

class ContinueButton extends StatefulWidget {
  final user;
  ContinueButton(this.user);
  @override
  State<StatefulWidget> createState() {
    return _continueButton();
  }
}

class _continueButton extends State<ContinueButton> {
  Future httpCall() async {
    print('httpCall made');
    print(widget.user);
    final response = await http.post(
      Uri.parse('https://10.0.2.2:5001/api/GoogleSignIn/GoogleLogin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'displayName': widget.user.displayName!,
        'email': widget.user.email!,
        'phoneNumber': widget.user.phoneNumber!,
        'googleImgUrl': widget.user.photoURL!,
      }),
    );
    if (response.statusCode == 200) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoticeBoard()));
    } else if (response.statusCode == 201) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => InfoForm()));
    } else {
      print(response.statusCode);
    }
  }

  Widget build(context) => Container(
        color: Colors.transparent,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(300)),
            ),
          ),
          onPressed: () {
            //make api call
            //api endpoint - displayName, email, number, uri
            //if 200 user goes to noticeboard, else 201 user goes to infoForm
            //receive statuscode 200 || thrownException || emailDomain does not match

            httpCall();
          },
          child: Text(
            'Continue',
            style: TextStyle(
              fontSize: 24,
              color: Color.fromRGBO(171, 255, 79, 1),
            ),
          ),
        ),
      );
}

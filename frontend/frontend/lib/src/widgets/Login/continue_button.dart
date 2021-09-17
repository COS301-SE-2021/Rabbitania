import 'dart:convert';
import 'dart:developer';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/helper/JWT/securityHelper.dart';
import 'package:frontend/src/helper/URL/urlHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardScreen.dart';
import 'package:frontend/src/screens/Login/supplyInfoScreen.dart';

class ContinueButton extends StatefulWidget {
  final user;
  ContinueButton(this.user);
  @override
  State<StatefulWidget> createState() {
    return _ContinueButton();
  }
}

class _ContinueButton extends State<ContinueButton> {
  UserProvider userProvider = UserProvider();

  SecurityHelper securityHelper = SecurityHelper();
  URLHelper url = new URLHelper();

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    googleLoginHttpCall();
  }

  Future googleLoginHttpCall() async {
    final baseURL = await url.getBaseURL();
    final userHelper = UserHelper();
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    setState(() {});
    final response = await http.post(
      Uri.parse(baseURL + '/api/Auth/GoogleLogin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $idToken'
      },
      body: jsonEncode(<String, dynamic>{
        'displayName': widget.user.displayName,
        'email': widget.user.providerData[0].email,
        'phoneNumber': widget.user.phoneNumber,
        'googleImgUrl': widget.user.photoURL,
      }),
    );
    if (response.statusCode == 200) {
      var userID = await userProvider.getUserID();
      var userStatus = await userProvider.getUserAdminStatus();
      userHelper.setUserID(userID);
      userHelper.setUserName(widget.user.displayName);
      userHelper.setAdminStatus(userStatus);

      setState(() {});

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoticeBoard()));
    } else if (response.statusCode == 201) {
      final fireStoreHelper = FireStoreHelper();
      int userID = await userProvider.getUserID();
      await fireStoreHelper.createNewUsersDocsWithUid(
          userID,
          widget.user.displayName,
          widget.user.providerData[0].email,
          widget.user.photoURL);
      bool userStatus = await userProvider.getUserAdminStatus();
      userHelper.setUserID(userID);
      userHelper.setAdminStatus(userStatus);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => InfoForm(widget.user),
          ),
          (r) => false);
    } else {
      showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text("Login Error"),
          content: new Text("There was an error"),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Close me!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
  }

  Widget build(context) => Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
          ),
          child: Container(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: Color.fromRGBO(171, 255, 79, 1),
            ),
          ),
          onPressed: () {
            googleLoginHttpCall();
          },
        ),
      );
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/widgets/Login/continue_button.dart';
import 'package:frontend/src/widgets/Login/login_fab.dart';
import '../../models/utilModel.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final utilModel = new UtilModel();
  UserHelper userHelper = UserHelper();

  Widget build(context) => Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'WELCOME TO RABBITANIA',
                    maxLines: 2,
                    style: TextStyle(
                      color: Color.fromRGBO(171, 255, 79, 1),
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            SvgPicture.string(utilModel.svgBackground),
            Container(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(300)),
                    color: Colors.transparent,
                    border: Border.all(
                      color: Color.fromRGBO(171, 255, 79, 1),
                      width: 3,
                    ),
                  ),
                  height: 300,
                  width: 300,
                  child: Container(
                    child: StreamBuilder(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasData) {
                            return Container(
                              child: ContinueButton(snapshot.data),
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Something went wrong'));
                          } else {
                            return LoginFab();
                          }
                        }),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

Widget buildLoading() => Center(child: CircularProgressIndicator());

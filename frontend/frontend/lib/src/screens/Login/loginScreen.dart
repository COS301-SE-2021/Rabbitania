import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/helper/Login/loginHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/widgets/Login/continue_button.dart';
import 'package:frontend/src/widgets/Login/login_fab.dart';
import '../../models/util_model.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _loginState();
  }
}

class _loginState extends State<Login> {
  final utilModel = new UtilModel();
  LoginHelper loginHelper = LoginHelper();

  Widget build(context) => Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Center(
            child: Container(
              child: Text(
                'Welcome to Rabbitania',
                maxLines: 2,
                style: TextStyle(
                  color: Color.fromRGBO(171, 255, 79, 1),
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            SvgPicture.string(utilModel.svg_background),
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
                            print(snapshot.data);
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

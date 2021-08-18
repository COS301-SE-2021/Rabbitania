import 'package:frontend/src/screens/Forum/forumCreateForumScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForumCreateCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: forumCreateTitleController,
                  cursorColor: Color.fromRGBO(171, 255, 79, 1),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                    ),
                    labelText: 'Forum Title',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

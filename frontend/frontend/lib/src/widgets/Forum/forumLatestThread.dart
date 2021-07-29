import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForumLatestThread extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ListTile(
            contentPadding:
                EdgeInsets.only(bottom: 10.0, top: 10, left: 20, right: 10),
            title: Container(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "Latest Thread",
                style: TextStyle(
                    letterSpacing: 2.0, color: Colors.white, fontSize: 22),
              ),
            ),
            subtitle: Text(
              "This Thread is the latest",
              style: TextStyle(color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

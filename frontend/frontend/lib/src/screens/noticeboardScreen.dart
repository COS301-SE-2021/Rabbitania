import 'package:flutter/material.dart';

class NoticeBoard extends StatefulWidget {
  createState() {
    return _NoticeBoard();
  }
}

class _NoticeBoard extends State<NoticeBoard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(

        child:Card(

          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.vpn_key),
                title: const Text('Urgent Announcement',
                    style: TextStyle(fontSize: 30)),
                subtitle: Text(
                  'All Employees',
                  style: TextStyle(color: Colors.red.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Due to a COVID outbreak in the office we will all have to work remotely from home',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Image.asset('../../../assets/images'),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  FlatButton(
                    textColor: const Color(0xFF0CFF00),
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Icon(Icons.thumb_up_sharp),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    textColor: const Color(0xFFFF0000),
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Icon(Icons.thumb_down_sharp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
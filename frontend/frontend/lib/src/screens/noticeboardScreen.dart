import 'package:flutter/material.dart';
import '../widgets/card_item.dart';

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
        height: 300,
        child: NoticeboardCard(),
      ),
    );
  }
}
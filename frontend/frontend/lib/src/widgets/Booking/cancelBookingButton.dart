import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CancelBookingButton extends StatelessWidget {
  Widget build(context) => SizedBox.fromSize(
        size: Size(70, 70),
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Color.fromRGBO(172, 255, 79, 1),
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                  Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

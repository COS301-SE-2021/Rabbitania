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
                    FontAwesomeIcons.times,
                    color: Color.fromRGBO(171, 255, 79, 1),
                    size: 35,
                  ),
                  Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(172, 255, 79, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

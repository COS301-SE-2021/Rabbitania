import 'package:flutter/material.dart';

class BookingCircularProgressIndicator extends StatelessWidget {
  Widget build(context) => Center(
        child: Stack(children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: new BoxDecoration(
                color: Color.fromRGBO(33, 33, 33, 1),
              ),
              child: Center(
                widthFactor: 0.5,
                heightFactor: 0.5,
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(171, 255, 79, 1),
                ),
              )),
        ]),
      );
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/widgets/Booking/cancelBookingButton.dart';

class ViewBookingCard extends StatefulWidget {
  final dayText;
  final dateText;
  final timeText;
  final locationText;
  final _key;

  ViewBookingCard(
      this._key, this.dayText, this.dateText, this.timeText, this.locationText);
  @override
  State<StatefulWidget> createState() => _viewBookingCard();
}

class _viewBookingCard extends State<ViewBookingCard> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          key: widget.key,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(172, 255, 79, 1),
              width: 4,
            ),
            color: Color.fromRGBO(33, 33, 33, 1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          widget.dayText + ',',
                          style: TextStyle(
                            color: Color.fromRGBO(172, 255, 79, 1),
                            fontSize: 30,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                        ),
                        Text(
                          widget.dateText,
                          style: TextStyle(
                            color: Color.fromRGBO(172, 255, 79, 1),
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Time Slot:',
                              style: TextStyle(
                                color: Color.fromRGBO(172, 255, 79, 1),
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              widget.timeText,
                              style: TextStyle(
                                color: Color.fromRGBO(172, 255, 79, 1),
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Office:',
                              style: TextStyle(
                                color: Color.fromRGBO(172, 255, 79, 1),
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              widget.locationText,
                              style: TextStyle(
                                color: Color.fromRGBO(172, 255, 79, 1),
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                ),
                CancelBookingButton(),
              ],
            ),
          ),
        ),
      );
}

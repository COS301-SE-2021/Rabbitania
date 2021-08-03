import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/widgets/Booking/cancelBookingButton.dart';

class ViewBookingCard extends StatefulWidget {
  final bookingDate;
  final timeSlot;
  final officeAPI;
  final _key;

  ViewBookingCard(this._key, this.bookingDate, this.timeSlot, this.officeAPI);
  @override
  State<StatefulWidget> createState() => _viewBookingCard();

  checkOfficeLocation(int officeAPI) {
    if (officeAPI == 0) {}
    if (officeAPI == 1) {}
  }
}

class _viewBookingCard extends State<ViewBookingCard> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          key: widget.key,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(172, 255, 79, 1),
              width: 4,
            ),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Fake Date',
                          style: TextStyle(
                            color: Color.fromRGBO(172, 255, 79, 1),
                            fontSize: 30,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 10),
                        ),
                        Text(
                          "Hello",
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
                              'Time Slot: ',
                              style: TextStyle(
                                color: Color.fromRGBO(172, 255, 79, 1),
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              "Hello",
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
                              'Office:  ',
                              style: TextStyle(
                                color: Color.fromRGBO(172, 255, 79, 1),
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              widget.officeAPI.toString(),
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

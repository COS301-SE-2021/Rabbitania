import 'package:flutter/material.dart';

class BookingDayScreenButton extends StatefulWidget {
  final dropdownValue;
  BookingDayScreenButton({this.dropdownValue});
  @override
  State<StatefulWidget> createState() => _BookingDayScreenButton();
}

class _BookingDayScreenButton extends State<BookingDayScreenButton> {
  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          width: 300,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(11),
              backgroundColor: MaterialStateProperty.all(
                Color.fromRGBO(172, 255, 79, 1),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  // side: BorderSide(
                  //   width: 2,
                  //   color: Color.fromRGBO(171, 255, 79, 1),
                  // ),
                  side: BorderSide(
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
            child: Text(
              'Book',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromRGBO(33, 33, 33, 1),
              ),
            ),
            onPressed: () {},
          ),
        ),
      );
}

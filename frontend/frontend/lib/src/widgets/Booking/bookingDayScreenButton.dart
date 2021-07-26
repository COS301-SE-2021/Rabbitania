import 'package:flutter/material.dart';

class BookingDayScreenButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookingDayScreenButton();
}

class _BookingDayScreenButton extends State<BookingDayScreenButton> {
  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          width: 200,
          height: 70,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color.fromRGBO(172, 255, 79, 1),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    width: 2,
                    color: Color.fromRGBO(171, 255, 79, 1),
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

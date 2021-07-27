import 'package:flutter/material.dart';

class BookingDayText extends StatefulWidget {
  final displayText;
  BookingDayText(this.displayText);
  _BookingDayTextState createState() => _BookingDayTextState();
}

class _BookingDayTextState extends State<BookingDayText> {
  String dropdownValue = 'No Booking';
  Widget build(BuildContext context) => Center(
        child: Container(
            child: Column(
          children: <Widget>[
            Center(
              child: Text(
                widget.displayText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 40,
                  color: Color.fromRGBO(172, 255, 79, 1),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Center(
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(172, 255, 79, 1), width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromRGBO(33, 33, 33, 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Color.fromRGBO(33, 33, 33, 1),
                    value: dropdownValue,
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.arrow_downward,
                          color: Color.fromRGBO(171, 255, 79, 1)),
                    ),
                    iconSize: 30,
                    elevation: 8,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Color.fromRGBO(172, 255, 79, 1),
                    ),
                    underline: Container(
                      height: 0,
                      color: Color.fromRGBO(33, 33, 33, 1),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      'No Booking',
                      'Pretoria',
                      'Braamfontein',
                      'Amsterdam'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(value)),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        )),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookingScheduleSpinbox extends StatefulWidget {
  final officeName;
  BookingScheduleSpinbox(this.officeName);

  _BookingScheduleSpinboxState createState() => _BookingScheduleSpinboxState();
}

class _BookingScheduleSpinboxState extends State<BookingScheduleSpinbox> {
  UtilModel utilModel = UtilModel();
  var spinBoxMorning = 0.0;
  var spinBoxAfternoon = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.officeName,
          style: TextStyle(color: utilModel.greenColor, fontSize: 25),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: SpinBox(
            key: Key('MorningSpinbox'),
            min: 1,
            max: 10000,
            textStyle: TextStyle(color: utilModel.greenColor, fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Morning Slot',
              labelStyle: TextStyle(color: utilModel.greenColor, fontSize: 25),
            ),
            incrementIcon: Icon(
              FontAwesomeIcons.plus,
              color: utilModel.greenColor,
              size: 25,
            ),
            decrementIcon: Icon(
              FontAwesomeIcons.minus,
              color: utilModel.greenColor,
              size: 25,
            ),
            cursorColor: Color.fromRGBO(171, 255, 79, 1),
            value: 0,
            onChanged: (value) => {spinBoxMorning = value},
            afterChange: () {
              print(spinBoxMorning);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: SpinBox(
            key: Key('AfternoonSpinbox'),
            min: 1,
            max: 10000,
            textStyle: TextStyle(color: utilModel.greenColor, fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Afternoon Slot',
              labelStyle: TextStyle(color: utilModel.greenColor, fontSize: 25),
            ),
            incrementIcon: Icon(
              FontAwesomeIcons.plus,
              color: utilModel.greenColor,
              size: 25,
            ),
            decrementIcon: Icon(
              FontAwesomeIcons.minus,
              color: utilModel.greenColor,
              size: 25,
            ),
            cursorColor: Color.fromRGBO(171, 255, 79, 1),
            value: 0,
            onChanged: (value) => print(value),
          ),
        ),
      ],
    );
  }
}

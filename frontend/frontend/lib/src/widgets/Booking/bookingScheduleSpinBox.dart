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
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            widget.officeName,
            style: TextStyle(color: utilModel.greenColor, fontSize: 25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
          child: SpinBox(
            key: Key('MorningSpinbox'),
            min: 1,
            max: 10000,
            textStyle: TextStyle(color: utilModel.greenColor, fontSize: 30),
            decoration: InputDecoration(
              labelText: 'Morning Slot',
              labelStyle: TextStyle(
                  color: Color.fromRGBO(57, 219, 188, 1), fontSize: 25),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
            ),
            incrementIcon: Icon(
              FontAwesomeIcons.plus,
              color: Color.fromRGBO(57, 219, 188, 1),
              size: 25,
            ),
            decrementIcon: Icon(
              FontAwesomeIcons.minus,
              color: Color.fromRGBO(57, 219, 188, 1),
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
          padding: const EdgeInsets.only(left: 50, right: 50, bottom: 10),
          child: SpinBox(
            key: Key('AfternoonSpinbox'),
            min: 1,
            max: 10000,
            textStyle: TextStyle(color: utilModel.greenColor, fontSize: 30),
            decoration: InputDecoration(
              labelText: 'Afternoon Slot',
              labelStyle: TextStyle(
                  color: Color.fromRGBO(57, 219, 188, 1), fontSize: 25),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
            ),
            incrementIcon: Icon(
              FontAwesomeIcons.plus,
              color: Color.fromRGBO(57, 219, 188, 1),
              size: 25,
            ),
            decrementIcon: Icon(
              FontAwesomeIcons.minus,
              color: Color.fromRGBO(57, 219, 188, 1),
              size: 25,
            ),
            cursorColor: Color.fromRGBO(171, 255, 79, 1),
            value: 0,
            onChanged: (value) => print(value),
          ),
        ),
        ElevatedButton(
          child: Text(
            "CREATE SCHEDULE",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(utilModel.greyColor),
            backgroundColor:
                MaterialStateProperty.all<Color>(utilModel.greenColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: new BorderRadius.all(
                  new Radius.circular(15.0),
                ),
                side: BorderSide(color: utilModel.greenColor),
              ),
            ),
          ),
          onPressed: () => null,
        ),
      ],
    );
  }
}

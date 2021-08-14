import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:frontend/src/helper/Booking/bookingHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookingScheduleSpinbox extends StatefulWidget {
  final officeName;
  final day;
  BookingScheduleSpinbox(this.officeName, this.day);

  _BookingScheduleSpinboxState createState() => _BookingScheduleSpinboxState();
}

class _BookingScheduleSpinboxState extends State<BookingScheduleSpinbox> {
  UtilModel utilModel = UtilModel();
  BookingHelper bookingHelper = BookingHelper();
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
            onChanged: (value) => {spinBoxAfternoon = value},
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
          onPressed: () async {
            int office = -1;
            if (widget.officeName == "PRETORIA OFFICE") {
              office = 0;
            } else if (widget.officeName == "BRAAMFONTEIN OFFICE") {
              office = 1;
            } else if (widget.officeName == "ASMTERDAM OFFICE") {
              office = 2;
            }
            // Morning Slot
            String slotMorning = widget.day + ",Morning";
            var create1 = await bookingHelper.createBookingSchedule(
                timeslot: slotMorning,
                office: office,
                availability: this.spinBoxMorning.toInt().toString());
            //Afternoon Slot
            String slotAfternoon = widget.day + ",Afternoon";
            var create2 = await bookingHelper.createBookingSchedule(
                timeslot: slotAfternoon,
                office: office,
                availability: this.spinBoxAfternoon.toInt().toString());

            if (create1 && create2) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Schedule Successfully Created!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(171, 255, 79, 1),
                      fontSize: 20,
                    ),
                  ),
                  duration: const Duration(milliseconds: 5000),
                  width: 300.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              );
            } else {
              return showDialog<void>(
                builder: (BuildContext context) {
                  return AlertDialog(
                    elevation: 5,
                    backgroundColor: Color.fromRGBO(33, 33, 33, 1),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 25),
                    title: Text("Error with Schedule Creation!"),
                    contentTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                    content: Text(
                        "There seems to be an error with creating a schedule... Please contact technical support if this error persists."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text(
                          "Close",
                          style: TextStyle(
                              color: Color.fromRGBO(33, 33, 33, 1),
                              fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: StadiumBorder(),
                        ),
                      ),
                    ],
                  );
                },
                context: context,
              );
            }
          },
        ),
      ],
    );
  }
}

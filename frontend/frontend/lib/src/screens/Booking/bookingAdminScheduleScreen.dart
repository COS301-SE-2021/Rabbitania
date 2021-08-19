import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/widgets/Booking/bookingAppBar.dart';
import 'package:frontend/src/widgets/Booking/bookingButton.dart';
import 'package:frontend/src/widgets/Booking/bookingDayButton.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/widgets/Booking/bookingDayScreenButton.dart';
import 'package:frontend/src/widgets/Booking/bookingDayText.dart';
import 'package:frontend/src/widgets/Booking/bookingScheduleButton.dart';
import 'package:frontend/src/widgets/Booking/bookingScheduleSpinBox.dart';
import 'package:frontend/src/widgets/NavigationBar/actionBar.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';

class BookingScheduleScreen extends StatefulWidget {
  final displayText;

  BookingScheduleScreen(this.displayText);
  @override
  _BookingScheduleState createState() => _BookingScheduleState();
}

class _BookingScheduleState extends State<BookingScheduleScreen> {
  var displayText;
  final utilModel = UtilModel();
  determineDisplayText() {
    switch (widget.displayText) {
      case 'M':
        this.displayText = 'Monday';
        break;
      case 'Tu':
        this.displayText = 'Tuesday';
        break;
      case 'W':
        this.displayText = 'Wednesday';
        break;
      case 'Th':
        this.displayText = 'Thursday';
        break;
      case 'F':
        this.displayText = 'Friday';
        break;
    }
  }

  initState() {
    determineDisplayText();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // floatingActionButton: FancyFab(
        //   numberOfItems: 0,
        //   icon1: Icons.share_location_outlined,
        //   onPressed1: () {},
        //   icon2: Icons.delete,
        //   onPressed2: () {},
        //   icon3: Icons.airplane_ticket,
        //   onPressed3: () {},
        // ),
        bottomNavigationBar: bnb(context),
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 220,
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.07,
                      bottom: 10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Booking Schedule',
                      style: TextStyle(
                        fontSize: 35,
                        color: Color.fromRGBO(172, 255, 79, 1),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  this.displayText == 'Monday'
                      ? new BookingScheduleButton(
                          'M',
                          Color.fromRGBO(63, 63, 63, 1),
                        ) //if true
                      : new BookingScheduleButton(
                          'M', Colors.transparent), //else
                  this.displayText == 'Tuesday'
                      ? new BookingScheduleButton(
                          'Tu',
                          Color.fromRGBO(63, 63, 63, 1),
                        ) //if true
                      : new BookingScheduleButton('Tu', Colors.transparent), //
                  this.displayText == 'Wednesday'
                      ? new BookingScheduleButton(
                          'W',
                          Color.fromRGBO(63, 63, 63, 1),
                        ) //if true
                      : new BookingScheduleButton('W', Colors.transparent),
                  this.displayText == 'Thursday'
                      ? new BookingScheduleButton(
                          'Th',
                          Color.fromRGBO(63, 63, 63, 1),
                        ) //if true
                      : new BookingScheduleButton('Th', Colors.transparent),
                  this.displayText == 'Friday'
                      ? new BookingScheduleButton(
                          'F',
                          Color.fromRGBO(63, 63, 63, 1),
                        ) //if true
                      : new BookingScheduleButton('F', Colors.transparent),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      this.displayText,
                      style: TextStyle(
                        fontSize: 28,
                        color: Color.fromRGBO(172, 255, 79, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        body: Center(
          child: Stack(
            children: <Widget>[
              // SvgPicture.string(
              //   utilModel.svg_background,
              //   fit: BoxFit.contain,
              // ),
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: BookingScheduleSpinbox(
                        'PRETORIA OFFICE', this.displayText),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: BookingScheduleSpinbox(
                        'BRAAMFONTEIN OFFICE', this.displayText),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: BookingScheduleSpinbox(
                        'AMSTERDAM OFFICE', this.displayText),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

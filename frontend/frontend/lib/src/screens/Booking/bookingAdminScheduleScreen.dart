import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/screens/Booking/bookingAdminHomeScreen.dart';
import 'package:frontend/src/screens/Booking/bookingScheduleScreen.dart';

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
  UserHelper userHelper = new UserHelper();
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

  @override
  initState() {
    determineDisplayText();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FancyFab(
          heroTag: "BookingSchedule",
          numberOfItems: 2,
          icon1: Icons.admin_panel_settings_sharp,
          onPressed1: () async {
            var name = await userHelper.getUserName();
            if (await userHelper.getAdminStatus()) {
              UtilModel.route(() => BookingAdminScreen(), context);
            } else {
              return showDialog<void>(
                builder: (BuildContext context) {
                  return AlertDialog(
                    key: Key('HomeAdminError'),
                    elevation: 5,
                    backgroundColor: Color.fromRGBO(33, 33, 33, 1),
                    titleTextStyle:
                        TextStyle(color: Colors.white, fontSize: 25),
                    title: Text("Permission Denied: "),
                    contentTextStyle:
                        TextStyle(color: Colors.white, fontSize: 20),
                    content: Text("Sorry " +
                        name +
                        ", You do not have permission to access admin related pages!"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text(
                          "Return",
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
          icon2: Icons.schedule,
          onPressed2: () {
            UtilModel.route(() => BookingSchedules(), context);
          },
          icon3: Icons.edit,
          onPressed3: () {},
        ),
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
                        )
                      : new BookingScheduleButton('M', Colors.transparent),
                  this.displayText == 'Tuesday'
                      ? new BookingScheduleButton(
                          'Tu',
                          Color.fromRGBO(63, 63, 63, 1),
                        )
                      : new BookingScheduleButton('Tu', Colors.transparent), //
                  this.displayText == 'Wednesday'
                      ? new BookingScheduleButton(
                          'W',
                          Color.fromRGBO(63, 63, 63, 1),
                        )
                      : new BookingScheduleButton('W', Colors.transparent),
                  this.displayText == 'Thursday'
                      ? new BookingScheduleButton(
                          'Th',
                          Color.fromRGBO(63, 63, 63, 1),
                        )
                      : new BookingScheduleButton('Th', Colors.transparent),
                  this.displayText == 'Friday'
                      ? new BookingScheduleButton(
                          'F',
                          Color.fromRGBO(63, 63, 63, 1),
                        )
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

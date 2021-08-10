import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/models/Booking/bookingModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/widgets/Booking/bookingAppBar.dart';
import 'package:frontend/src/widgets/Booking/bookingButton.dart';
import 'package:frontend/src/widgets/Booking/bookingDayButton.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/widgets/Booking/bookingViewButton.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<BookingScreen> {
  UtilModel utilModel = UtilModel();
  List<bool> colorArray = [true, false, false, false, false];

  @override
  initState() {}

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          //Floating action button on Scaffold
          onPressed: () {
            //code to execute on button press
          },
          backgroundColor: Color.fromRGBO(172, 255, 79, 1),
          child: Icon(Icons.apps_sharp,
              color: Color.fromRGBO(33, 33, 33, 1)), //icon inside button
        ),
        floatingActionButtonLocation: fabl(context),
        bottomNavigationBar: bnb(context),
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 120,
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: Colors.transparent,
          flexibleSpace: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Booking',
                      style: TextStyle(
                        fontSize: 35,
                        color: Color.fromRGBO(172, 255, 79, 1),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  BookingDayButton('M', Colors.transparent),
                  BookingDayButton('Tu', Colors.transparent),
                  BookingDayButton('W', Colors.transparent),
                  BookingDayButton('Th', Colors.transparent),
                  BookingDayButton('F', Colors.transparent),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        // 63 63 63
        body: Center(
          child: Stack(
            children: <Widget>[
              SvgPicture.string(
                utilModel.svg_background,
                fit: BoxFit.contain,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 75.0, bottom: 25.0),
                    child: Image(
                      image: AssetImage('images/logo.png'),
                      height: 150,
                      width: 400,
                    ),
                  ),
                  Container(
                    child: BookingViewButton(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Booking/bookingAdminHomeScreen.dart';
import 'package:frontend/src/widgets/Booking/bookingDayButton.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/widgets/Booking/bookingViewButton.dart';
import 'package:frontend/src/widgets/NavigationBar/actionBar.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';

class BookingSchedules extends StatefulWidget {
  @override
  _BookingScheduleState createState() => _BookingScheduleState();
}

class _BookingScheduleState extends State<BookingSchedules> {
  UtilModel utilModel = UtilModel();
  UserHelper loggedUser = new UserHelper();

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FancyFab(
          heroTag: "BookingSchedulesPage",
          numberOfItems: 0,
          icon1: Icons.admin_panel_settings_sharp,
          onPressed1: () {},
          icon2: Icons.schedule,
          onPressed2: () {},
          icon3: Icons.edit,
          onPressed3: () {},
        ),
        bottomNavigationBar: bnb(context),
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 220,
          automaticallyImplyLeading: false,
          elevation: 1,
          backgroundColor: Colors.transparent,
          flexibleSpace: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.07,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Booking Schedules',
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
                  BookingDayButton('M', Colors.transparent),
                  BookingDayButton('Tu', Colors.transparent),
                  BookingDayButton('W', Colors.transparent),
                  BookingDayButton('Th', Colors.transparent),
                  BookingDayButton('F', Colors.transparent),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      'No Day Selected',
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Image(
                        image: AssetImage('images/logo.png'),
                        height: 150,
                        width: 500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

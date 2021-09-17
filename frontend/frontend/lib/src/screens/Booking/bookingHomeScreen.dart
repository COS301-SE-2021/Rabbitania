import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/screens/Booking/bookingAdminHomeScreen.dart';
import 'package:frontend/src/screens/Booking/bookingScheduleScreen.dart';
import 'package:frontend/src/widgets/Booking/bookingDayButton.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/widgets/Booking/bookingViewButton.dart';
import 'package:frontend/src/widgets/NavigationBar/actionBar.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<BookingScreen> {
  UtilModel utilModel = UtilModel();
  UserHelper loggedUser = new UserHelper();

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FancyFab(
          heroTag: "BookingScreenPage",
          numberOfItems: 2,
          icon1: Icons.admin_panel_settings_sharp,
          onPressed1: () async {
            var name = await loggedUser.getUserName();
            if (await loggedUser.getAdminStatus()) {
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
          automaticallyImplyLeading: false,
          title: Text(
            'Booking Home',
            style: TextStyle(
              fontSize: 35,
              color: Color.fromRGBO(172, 255, 79, 1),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        body: Center(
          child: Stack(
            children: <Widget>[
              SvgPicture.string(
                utilModel.svgBackground,
                fit: BoxFit.contain,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: BookingViewButton(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

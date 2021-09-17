import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/screens/Booking/bookingScheduleScreen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/widgets/Booking/bookingScheduleButton.dart';
import 'package:frontend/src/widgets/NavigationBar/actionBar.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';

class BookingAdminScreen extends StatefulWidget {
  BookingAdminScreen();

  @override
  _BookingAdminState createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingAdminScreen> {
  UtilModel utilModel = UtilModel();
  UserHelper userHelper = new UserHelper();

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FancyFab(
          heroTag: "BookingAdminHome",
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
          elevation: 0,
          title: Text(
            'Admin Booking',
            style: TextStyle(
              fontSize: 35,
              color: Color.fromRGBO(172, 255, 79, 1),
            ),
          ),
          automaticallyImplyLeading: false,
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
                      BookingScheduleButton('M', Colors.transparent),
                      BookingScheduleButton('Tu', Colors.transparent),
                      BookingScheduleButton('W', Colors.transparent),
                      BookingScheduleButton('Th', Colors.transparent),
                      BookingScheduleButton('F', Colors.transparent),
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

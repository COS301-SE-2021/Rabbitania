import 'package:flutter/material.dart';
import 'package:frontend/src/models/Booking/bookingScheduleModel.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/provider/booking_provider.dart';

class BookingGridSchedule extends StatefulWidget {
  BookingGridSchedule();
  _BookingGridState createState() => _BookingGridState();
}

class _BookingGridState extends State<BookingGridSchedule> {
  final _bookingProvider = new BookingProvider();
  UtilModel utilModel = new UtilModel();

  Widget build(BuildContext context) {
    return FutureBuilder<List<BookingScheduleModel>>(
      future: _bookingProvider.fetchSchedulesAsync(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<BookingScheduleModel>? data = snapshot.data;
          if (snapshot.data!.length == 0) {
            return GridView.count(
              crossAxisCount: 2,
              children: [
                Card(
                  color: Color.fromRGBO(57, 57, 57, 25),
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  clipBehavior: Clip.antiAlias,
                  elevation: 2,
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(
                            bottom: 5.0, top: 10, left: 20, right: 10),
                        title: Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "No schedules currently",
                            style: TextStyle(
                                letterSpacing: 2.0,
                                color: Colors.white,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return GridView.builder(
              itemCount: data!.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return _scheduleCard(
                  Icons.schedule,
                  data[index].timeSlot,
                  data[index].office,
                  data[index].availability,
                );
              },
            );
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
              Color.fromRGBO(171, 255, 79, 1),
            ),
          ),
        );
      },
    );
  }

  Card _scheduleCard(
      IconData icon, String timeSlot, int office, int availability) {
    var resTimeSlot = timeSlot.split(',');
    var day = resTimeSlot[0];
    var slot = resTimeSlot[1];
    var officeName;
    if (office == 0) {
      officeName = "Pretoria";
    } else if (office == 1) {
      officeName = "Braamfontein";
    } else if (office == 2) {
      officeName = "Amsterdam";
    }

    if (availability == 0) {
      return Card(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                icon,
                color: Colors.red,
                size: 35,
              ),
              title: Text(
                day,
                style: TextStyle(
                  color: utilModel.greenColor,
                  fontSize: 20,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(bottom: 2, left: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Slot: ' + slot,
                    style: TextStyle(
                      color: utilModel.greenColor,
                      fontSize: 20,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, left: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Office: ' + officeName,
                    style: TextStyle(
                      color: utilModel.greenColor,
                      fontSize: 20,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                availability.toString(),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 40,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Card(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                icon,
                color: Color.fromRGBO(57, 219, 188, 1),
                size: 35,
              ),
              title: Text(
                day,
                style: TextStyle(
                  color: utilModel.greenColor,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(bottom: 2, left: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Slot: ' + slot,
                    style: TextStyle(color: utilModel.greenColor, fontSize: 20),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, left: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Office: ' + officeName,
                    style: TextStyle(
                      color: utilModel.greenColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                availability.toString(),
                style: TextStyle(
                  color: Color.fromRGBO(57, 219, 188, 1),
                  fontSize: 40,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

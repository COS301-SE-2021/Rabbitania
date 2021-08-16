import 'package:flutter/material.dart';
import 'package:frontend/src/models/Booking/bookingScheduleModel.dart';
import 'package:frontend/src/models/util_model.dart';
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
          // print(snapshot.data!.map((element) {
          //   return element.timeSlot;
          // }));
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
                  crossAxisCount: 3),
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
        return CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
            Color.fromRGBO(171, 255, 79, 1),
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

    return Card(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          //Icon(icon:icon),
          Text(
            day,
            style: TextStyle(color: utilModel.greenColor),
          ),
          Text(
            slot,
            style: TextStyle(color: utilModel.greenColor),
          ),
          Text(
            officeName,
            style: TextStyle(color: utilModel.greenColor),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/src/models/Booking/bookingScheduleModel.dart';
import 'package:frontend/src/provider/booking_provider.dart';

class BookingGridSchedule extends StatefulWidget {
  BookingGridSchedule();
  _BookingGridState createState() => _BookingGridState();
}

class _BookingGridState extends State<BookingGridSchedule> {
  final _bookingProvider = new BookingProvider();

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
            return _scheduleCard(data);
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

  Card _scheduleCard(data) {
    return Card(
      color: Colors.transparent,
      child: Text('Helloo'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/models/Booking/bookingModel.dart';
import 'package:frontend/src/provider/booking_provider.dart';
import 'package:frontend/src/widgets/Booking/cancelBookingButton.dart';

class BookingListVew extends StatelessWidget {
  final _bookingProvider = new BookingProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ViewBookingModel>>(
      future: _bookingProvider.fetchBookingsAsync(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ViewBookingModel>? data = snapshot.data;
          return _bookingCardListView(data);
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

  /*
  final int id;
  final String bookingDate;
  final String timeSlot;
  final int office;
  final int userId;
  */
  ListView _bookingCardListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _bookingCardTile(data[index].timeSlot, data[index].bookingDate,
              data[index].office, Icons.bookmark_added_outlined);
        });
  }

  ListTile _bookingCardTile(
          String title, String subtitle, int subsubtitle, IconData icon) =>
      ListTile(
        isThreeLine: true,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(171, 255, 79, 1),
            fontSize: 25,
          ),
        ),
        subtitle: Text(
          'Time Slot: ' + subtitle.toString(),
          style: TextStyle(
            color: Color.fromRGBO(171, 255, 79, 1),
            fontSize: 20,
          ),
        ),
        trailing: CancelBookingButton(),
        leading: Icon(
          icon,
          size: 35,
          color: Color.fromRGBO(171, 255, 79, 1),
        ),
      );
}

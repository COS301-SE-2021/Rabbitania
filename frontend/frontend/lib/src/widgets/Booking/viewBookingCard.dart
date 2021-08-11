import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/models/Booking/bookingModel.dart';
import 'package:frontend/src/provider/booking_provider.dart';
import 'package:frontend/src/widgets/Booking/cancelBookingButton.dart';

class BookingListView extends StatefulWidget {
  @override
  _BookingListView createState() => _BookingListView();
}

class _BookingListView extends State<BookingListView> {
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

  ListView _bookingCardListView(data) {
    BookingProvider bookingProvider = new BookingProvider();

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(
            data[index].id.toString(),
          ),
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirm"),
                  content:
                      const Text("Are you sure you wish to delete this item?"),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("DELETE")),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("CANCEL"),
                    ),
                  ],
                );
              },
            );
          },
          onDismissed: (direction) {
            bookingProvider.deleteBookingAsync(data[index].id);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Booking Successfully Deleted',
                  style: TextStyle(
                    color: Color.fromRGBO(171, 255, 79, 1),
                    fontSize: 20,
                  ),
                ),
                duration: const Duration(milliseconds: 5000),
                width: 300.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            );
          },
          background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.25,
                    ),
                    child: Icon(
                      FontAwesomeIcons.trash,
                      size: 35,
                      color: Color.fromRGBO(33, 33, 33, 1),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.25,
                    ),
                    child: Icon(
                      FontAwesomeIcons.trash,
                      size: 35,
                      color: Color.fromRGBO(33, 33, 33, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: CustomListItem(
            Icons.bookmark_added_outlined,
            data[index].timeSlot,
            data[index].office,
            data[index].bookingDate,
            data[index].id,
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class CustomListItem extends StatelessWidget {
  CustomListItem(
      this.icon, this.timeslot, this.office, this.bookingDate, this.id);

  final IconData icon;
  final String timeslot;
  final int office;
  final String bookingDate;
  final int id;

  late var splitSlot = timeslot.split(",");
  late String day = splitSlot[0];
  late String slot = splitSlot[1];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                icon,
                size: 50,
                color: Color.fromRGBO(171, 255, 79, 1),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: _BookingInformation(
              day: day,
              slot: slot,
              office: office,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingInformation extends StatelessWidget {
  const _BookingInformation({
    Key? key,
    required this.day,
    required this.slot,
    required this.office,
  }) : super(key: key);

  final String day;
  final String slot;
  final int office;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Day:     ' + day,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(171, 255, 79, 1),
              fontSize: 22,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            'Slot:     ' + slot.toString(),
            style: TextStyle(
              color: Color.fromRGBO(171, 255, 79, 1),
              fontSize: 22,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            'Office:  ' + office.toString(),
            style: TextStyle(
              color: Color.fromRGBO(171, 255, 79, 1),
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}

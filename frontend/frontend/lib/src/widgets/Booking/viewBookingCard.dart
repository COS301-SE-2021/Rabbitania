import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/models/Booking/bookingModel.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/provider/booking_provider.dart';

class BookingListView extends StatefulWidget {
  @override
  _BookingListView createState() => _BookingListView();
}

class _BookingListView extends State<BookingListView> {
  final _bookingProvider = new BookingProvider();
  final utilModel = UtilModel();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ViewBookingModel>>(
      future: _bookingProvider.fetchBookingsAsync(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ViewBookingModel>? data = snapshot.data;
          if (snapshot.data!.length == 0) {
            return ListView(
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
                            "No Bookings Made",
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
            return _bookingCardListView(data);
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
                  elevation: 5,
                  backgroundColor: Color.fromRGBO(33, 33, 33, 1),
                  titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
                  title: Text("DELETE BOOKING: "),
                  contentTextStyle:
                      TextStyle(color: Colors.white, fontSize: 20),
                  content:
                      Text("Are you sure you want to delete this booking?"),
                  actions: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      icon: Icon(Icons.close, color: Colors.red),
                    ),
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        icon: Icon(Icons.check, color: utilModel.greenColor)),
                  ],
                );
              },
            );
          },
          onDismissed: (direction) {
            bookingProvider.deleteBookingAsync(data[index].id).then((value) {
              if (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Booking Successfully Deleted',
                      textAlign: TextAlign.center,
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
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Error with deleting booking',
                      textAlign: TextAlign.center,
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
              }
            });
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

  late String tempOfficeName;

  @override
  Widget build(BuildContext context) {
    if (office == 0) {
      tempOfficeName = "Pretoria";
    } else if (office == 1) {
      tempOfficeName = "Braamfontein";
    } else if (office == 2) {
      tempOfficeName = "Amsterdam";
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromRGBO(171, 255, 79, 1),
          width: 0.5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                office: tempOfficeName,
              ),
            ),
          ],
        ),
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
  final String office;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                'Day: ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(57, 219, 188, 1),
                  fontSize: 22,
                ),
              ),
              Text(
                day,
                style: TextStyle(
                  color: Color.fromRGBO(171, 255, 79, 1),
                  fontSize: 22,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Row(
            children: [
              Text(
                'Slot: ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(57, 219, 188, 1),
                  fontSize: 22,
                ),
              ),
              Text(
                slot,
                style: TextStyle(
                  color: Color.fromRGBO(171, 255, 79, 1),
                  fontSize: 22,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Row(
            children: [
              Text(
                'Office: ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(57, 219, 188, 1),
                  fontSize: 22,
                ),
              ),
              Text(
                office,
                style: TextStyle(
                  color: Color.fromRGBO(171, 255, 79, 1),
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

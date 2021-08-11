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
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");

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
      // itemBuilder: (context, index) {
      //   return CustomListItem(
      //     Icons.bookmark_added_outlined,
      //     data[index].timeSlot,
      //     data[index].office,
      //     data[index].bookingDate,
      //     data[index].id,
      //   );
      // },
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(
            data[index].id.toString(),
          ),
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
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                child: Text(
                  'DELETE \nBOOKING',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                ),
              ),
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

//   ListTile _bookingCardTile(String title, String subtitle, int subsubtitle,
//           int id, IconData icon) =>
//       ListTile(
//         isThreeLine: true,
//         title: Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.w500,
//             color: Color.fromRGBO(171, 255, 79, 1),
//             fontSize: 25,
//           ),
//         ),
//         subtitle: Text(
//           'Time Slot: ' + subtitle.toString(),
//           style: TextStyle(
//             color: Color.fromRGBO(171, 255, 79, 1),
//             fontSize: 20,
//           ),
//         ),
//         trailing: CancelBookingButton(id),
//         leading: Icon(
//           icon,
//           size: 35,
//           color: Color.fromRGBO(171, 255, 79, 1),
//         ),
//       );
}

class CustomListItem extends StatelessWidget {
  const CustomListItem(
      this.icon, this.slot, this.office, this.bookingDate, this.id);

  final IconData icon;
  final String slot;
  final int office;
  final String bookingDate;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Icon(
              icon,
              size: 45,
              color: Color.fromRGBO(171, 255, 79, 1),
            ),
          ),
          Expanded(
            flex: 3,
            child: _BookingInformation(
              day: slot,
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
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            day,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(171, 255, 79, 1),
              fontSize: 24,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            'Slot: ' + slot.toString(),
            style: TextStyle(
              color: Color.fromRGBO(171, 255, 79, 1),
              fontSize: 20,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            'Office: ' + office.toString(),
            style: TextStyle(
              color: Color.fromRGBO(171, 255, 79, 1),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

//   ListView _bookingCardListView(data) {
//     return ListView.builder(
//         itemCount: data.length,
//         itemBuilder: (context, index) {
//           return _bookingCardTile(
//               data[index].timeSlot,
//               data[index].bookingDate,
//               data[index].office,
//               data[index].id,
//               Icons.bookmark_added_outlined);
//         });
//   }

/// This is the stateless widget that the main application instantiates.
// class MyStatelessWidget extends StatelessWidget {
//   const MyStatelessWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         CustomListItem(
//           user: 'Morning',
//           viewCount: 'Pretoria',
//           starting: Icon(
//             Icons.bookmark_added_outlined,
//             size: 45,
//             color: Color.fromRGBO(171, 255, 79, 1),
//           ),
//           title: 'Monday',
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:frontend/src/provider/booking_provider.dart';

// class BookingDayScreenButton extends StatefulWidget {
//   final String officeLocation;
//   final String timeOfDay;
//   final String dayOfTheWeek;
//   late String timeSlot = dayOfTheWeek + "," + timeOfDay;
//   late bool isDisabled;

//   BookingDayScreenButton(
//       this.officeLocation, this.timeOfDay, this.dayOfTheWeek);

//   @override
//   State<StatefulWidget> createState() => _BookingDayScreenButton();
// }

// int getOfficeIndex(String office) {
//   int officeIndex = -1;
//   if (office == 'Pretoria') {
//     officeIndex = 0;
//   } else if (office == 'Braamfontein') {
//     officeIndex = 1;
//   } else if (office == 'Amsterdam') {
//     officeIndex = 2;
//   }

//   return officeIndex;
// }

// class _BookingDayScreenButton extends State<BookingDayScreenButton> {
//   final _bookingProvider = new BookingProvider();
//   final DateTime date = DateTime.now();

//   @override
//   Widget build(BuildContext context) => Center(
//         child: SizedBox(
//           width: 400,
//           height: 100,
//           child: ElevatedButton(
//             style: ButtonStyle(
//               elevation: MaterialStateProperty.all(11),
//               backgroundColor: MaterialStateProperty.all(
//                 Color.fromRGBO(172, 255, 79, 1),
//               ),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                   side: BorderSide(
//                     style: BorderStyle.none,
//                   ),
//                 ),
//               ),
//             ),
//             child: Text(
//               'Book',
//               style: TextStyle(
//                 fontSize: 30,
//                 color: Color.fromRGBO(33, 33, 33, 1),
//               ),
//             ),
//             onPressed: () {},
//           ),
//         ),
//       );
// }

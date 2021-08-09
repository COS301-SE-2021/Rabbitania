import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Booking/bookingHelper.dart';
import 'package:frontend/src/provider/booking_provider.dart';
import 'package:frontend/src/widgets/Booking/bookingCircularProgressIndicator.dart';
import 'package:frontend/src/widgets/Booking/bookingDayScreenButton.dart';
import 'package:frontend/src/widgets/Booking/bookingSucessSnackBar.dart';

class BookingDayText extends StatefulWidget {
  final String displayText;
  final String dayOfTheWeek;
  late String bookText;

  BookingDayText(this.displayText, this.dayOfTheWeek, this.bookText);
  @override
  _BookingDayTextState createState() => _BookingDayTextState();
}

class _BookingDayTextState extends State<BookingDayText> {
  String dropdownValue = 'No Selection';
  String dropdownValue2 = 'No Selection';
  String selectedOffice = '';
  String selectedTimeSlot = '';

  final _bookingProvider = new BookingProvider();

  List<String> officeLocations = [
    'No Selection',
    'Pretoria',
    'Braamfontein',
    'Amsterdam',
  ];

  List<String> timeSlots = ['No Selection', 'Morning', 'Afternoon'];

  int getOfficeIndex(String office) {
    int officeIndex = -1;
    if (office == 'Pretoria') {
      officeIndex = 0;
    } else if (office == 'Braamfontein') {
      officeIndex = 1;
    } else if (office == 'Amsterdam') {
      officeIndex = 2;
    }
    return officeIndex;
  }

  void getDropDownItem() {
    setState(() {
      selectedOffice = dropdownValue;
      selectedTimeSlot = dropdownValue2;
    });
  }

  Widget build(BuildContext context) => Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Office Location: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                    color: Color.fromRGBO(172, 255, 79, 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Center(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(172, 255, 79, 1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Color.fromRGBO(33, 33, 33, 1),
                      value: dropdownValue,
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.arrow_downward,
                            color: Color.fromRGBO(171, 255, 79, 1)),
                      ),
                      iconSize: 30,
                      elevation: 8,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Color.fromRGBO(172, 255, 79, 1),
                      ),
                      underline: Container(
                        height: 0,
                        color: Color.fromRGBO(33, 33, 33, 1),
                      ),
                      onChanged: (String? office) {
                        setState(() {
                          dropdownValue = office!;
                        });
                      },
                      items: officeLocations
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
              ),
              Center(
                child: Text(
                  'Time Slot: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                    color: Color.fromRGBO(172, 255, 79, 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Center(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(172, 255, 79, 1), width: 2),
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Color.fromRGBO(33, 33, 33, 1),
                      value: dropdownValue2,
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.arrow_downward,
                            color: Color.fromRGBO(171, 255, 79, 1)),
                      ),
                      iconSize: 30,
                      elevation: 8,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Color.fromRGBO(172, 255, 79, 1),
                      ),
                      underline: Container(
                        height: 0,
                        color: Color.fromRGBO(33, 33, 33, 1),
                      ),
                      onChanged: (String? time) {
                        setState(() {
                          dropdownValue2 = time!;
                        });
                      },
                      items: timeSlots
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                //child: BookingDayScreenButton(this.dropdownValue,
                //  widget.displayText, widget.dayOfTheWeek),
                child: SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(11),
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(172, 255, 79, 1),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    child: Text(
                      "Book",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromRGBO(33, 33, 33, 1),
                      ),
                    ),
                    onPressed: () {
                      int office = this.getOfficeIndex(this.dropdownValue);
                      DateTime date = DateTime.now();
                      String timeSlot =
                          widget.dayOfTheWeek + "," + this.dropdownValue2;
                      // await _bookingProvider.createBookingAsync(
                      //     date.toString(), timeSlot, office, 1);
                      // print(this.getOfficeIndex(this.dropdownValue));
                      // print(timeSlot);

                      //return a futureBuilder that makes call to helper function
                      final BookingHelper bookingHelper = BookingHelper();

                      Widget build(context) => FutureBuilder<bool>(
                            future: bookingHelper.checkAndMakeBooking(
                                timeslot: timeSlot,
                                office: office,
                                bookingDate: date),
                            builder: (context, snapshot) {
                              List<Widget> children = [];
                              if (snapshot.hasData) {
                                //if future return true then show alert to let user know the booking has been made
                                if (snapshot.data == true) {
                                  //snackBar to show that booking has been made successfully
                                  children = <Widget>[
                                    SuccessBookingSnackBar(),
                                  ];
                                } else {
                                  //if future returns false then show alert dialog to notify user that no bookings are availible
                                }
                              } else if (snapshot.hasError) {
                                children = <Widget>[
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text('Error: ${snapshot.error}'),
                                  )
                                ];
                              } else {
                                //show progress indicator when future is loading
                                children = <Widget>[
                                  BookingCircularProgressIndicator(),
                                ];
                              }
                              return Center(
                                child: Column(children: children),
                              );
                            },
                          );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

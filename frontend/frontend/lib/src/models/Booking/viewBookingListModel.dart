import 'package:flutter/material.dart';
import 'package:frontend/src/models/Booking/view_booking_model.dart';

class ViewBookingListModel {
  final List<ViewBookingModel> bookingList;
  ViewBookingListModel(this.bookingList);
  List<ViewBookingModel> getBookingList() {
    return this.bookingList;
  }
}

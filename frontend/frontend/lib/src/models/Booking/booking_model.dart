import 'package:flutter/material.dart';

class BookingModel {
  var bookingColorArray = [false, false, false, false, false];
  setArrayItemTrue(index) {
    this.bookingColorArray[index] = true;
  }

  getColorArray() {
    return this.bookingColorArray;
  }
}

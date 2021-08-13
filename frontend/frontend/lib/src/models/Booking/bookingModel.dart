class ViewBookingModel {
  final int id;
  final String bookingDate;
  final String timeSlot;
  final int office;
  final int userId;

  ViewBookingModel(
      {required this.id,
      required this.bookingDate,
      required this.timeSlot,
      required this.office,
      required this.userId});

  factory ViewBookingModel.fromJson(Map<String, dynamic> json) {
    return ViewBookingModel(
        id: json['bookingId'],
        bookingDate: json['bookingDate'],
        timeSlot: json['timeSlot'],
        office: json['office'],
        userId: json['userId']);
  }
}

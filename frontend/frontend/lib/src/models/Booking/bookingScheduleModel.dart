class BookingScheduleModel {
  final String timeSlot; // composite key
  final String office; // composite key
  final int availability;

  BookingScheduleModel(
      {required this.timeSlot,
      required this.office,
      required this.availability});

  factory BookingScheduleModel.fromJson(Map<String, dynamic> json) {
    return BookingScheduleModel(
        timeSlot: json['timeSlot'],
        office: json['office'],
        availability: json['availability']);
  }
}

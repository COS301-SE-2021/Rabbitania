//model used to model a booking schedule model
class BookingScheduleModel {
  final String timeSlot;
  final int office;
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

namespace backend_api.Models.Booking.Responses
{
    public class GetBookingScheduleResponse
    {
        private BookingSchedule _bookingSchedule;

        public GetBookingScheduleResponse(BookingSchedule bookingSchedule)
        {
            _bookingSchedule = bookingSchedule;
        }

        public GetBookingScheduleResponse()
        {
        }

        public BookingSchedule BookingSchedule
        {
            get => _bookingSchedule;
            set => _bookingSchedule = value;
        }
    }
}
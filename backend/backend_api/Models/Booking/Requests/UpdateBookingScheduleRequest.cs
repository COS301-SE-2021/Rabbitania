using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class UpdateBookingScheduleRequest
    {
        private string _timeSlot;
        private OfficeLocation _office;
        private int _availability;

        public UpdateBookingScheduleRequest(string timeSlot, OfficeLocation office, int availability)
        {
            _timeSlot = timeSlot;
            _office = office;
            _availability = availability;
        }

        public string TimeSlot
        {
            get => _timeSlot;
            set => _timeSlot = value;
        }

        public OfficeLocation Office
        {
            get => _office;
            set => _office = value;
        }

        public int Availability
        {
            get => _availability;
            set => _availability = value;
        }
    }
}
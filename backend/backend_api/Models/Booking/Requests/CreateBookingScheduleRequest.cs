using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class CreateBookingScheduleRequest
    {
        private string _timeSlot;
        private OfficeLocation _office;
        private int _availability;

        public CreateBookingScheduleRequest(string timeSlot, OfficeLocation office, int availability)
        {
            this._office = office;
            this._timeSlot = timeSlot;
            this._availability = availability;
        }

        public CreateBookingScheduleRequest()
        {
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
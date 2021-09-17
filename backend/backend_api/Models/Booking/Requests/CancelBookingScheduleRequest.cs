using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class CancelBookingScheduleRequest
    {
        private string _timeSlot;
        private OfficeLocation _office;

        public CancelBookingScheduleRequest(string timeSlot, OfficeLocation office)
        {
            this._timeSlot = timeSlot;
            this._office = office;
        }

        public CancelBookingScheduleRequest()
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
    }
}
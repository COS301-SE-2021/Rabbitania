using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class CheckScheduleAvailabilityRequest
    {
        private string _timeSlot;
        private OfficeLocation _office;

        public CheckScheduleAvailabilityRequest(string timeSlot, OfficeLocation office)
        {
            this._timeSlot = timeSlot;
            this._office = office;
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
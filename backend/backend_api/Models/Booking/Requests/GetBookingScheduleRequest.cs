using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class GetBookingScheduleRequest
    {
        private string _timeSlot;
        private OfficeLocation _office;
        
        public GetBookingScheduleRequest(string timeSlot, OfficeLocation office)
        {
            TimeSlot = timeSlot;
            this._office = office;
        }

        public GetBookingScheduleRequest()
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
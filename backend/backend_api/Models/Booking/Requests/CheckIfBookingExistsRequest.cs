using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class CheckIfBookingExistsRequest
    {
        private string _timeSlot;
        private OfficeLocation _office;
        private int _userId;

        public CheckIfBookingExistsRequest(string timeSlot, OfficeLocation office, int userId)
        {
            _timeSlot = timeSlot;
            _office = office;
            _userId = userId;
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

        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }
    }
}
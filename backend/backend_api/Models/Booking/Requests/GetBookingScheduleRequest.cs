using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class GetBookingScheduleRequest
    {
        private string timeSlot;
        private OfficeLocation office;
        
        public GetBookingScheduleRequest(string timeSlot, OfficeLocation office)
        {
            TimeSlot = timeSlot;
            this.office = office;
        }

        public GetBookingScheduleRequest()
        {
        }
        
        public string TimeSlot
        {
            get => timeSlot;
            set => timeSlot = value;
        }

        public OfficeLocation Office
        {
            get => office;
            set => office = value;
        }
    }
}
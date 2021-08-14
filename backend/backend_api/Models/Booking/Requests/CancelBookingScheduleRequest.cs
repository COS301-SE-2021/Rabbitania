using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class CancelBookingScheduleRequest
    {
        private string timeSlot;
        private OfficeLocation office;

        public CancelBookingScheduleRequest(string timeSlot, OfficeLocation office)
        {
            this.timeSlot = timeSlot;
            this.office = office;
        }

        public CancelBookingScheduleRequest()
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
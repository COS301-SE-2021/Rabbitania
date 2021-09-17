using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class CheckScheduleAvailabilityRequest
    {
        private string timeSlot;
        private OfficeLocation office;

        public CheckScheduleAvailabilityRequest(string timeSlot, OfficeLocation office)
        {
            this.timeSlot = timeSlot;
            this.office = office;
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
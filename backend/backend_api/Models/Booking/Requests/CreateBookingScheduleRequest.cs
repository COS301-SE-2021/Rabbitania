using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class CreateBookingScheduleRequest
    {
        private OfficeLocation office;
        private string timeSlot;
        private int availability;

        public CreateBookingScheduleRequest(OfficeLocation office, string timeSlot, int availability)
        {
            this.office = office;
            this.timeSlot = timeSlot;
            this.availability = availability;
        }

        public CreateBookingScheduleRequest()
        {
        }

        public OfficeLocation Office
        {
            get => office;
            set => office = value;
        }

        public string TimeSlot
        {
            get => timeSlot;
            set => timeSlot = value;
        }

        public int Availability
        {
            get => availability;
            set => availability = value;
        }
    }
}
using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class GetAllBookingSchedulesRequest
    {
        private OfficeLocation office;
        private string timeSlot;

        public GetAllBookingSchedulesRequest()
        {
        }

        public GetAllBookingSchedulesRequest(OfficeLocation office)
        {
            this.office = office;
        }

        public GetAllBookingSchedulesRequest(string timeSlot)
        {
            this.timeSlot = timeSlot;
        }

        public GetAllBookingSchedulesRequest(OfficeLocation office, string timeSlot)
        {
            this.office = office;
            this.timeSlot = timeSlot;
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
    }
}
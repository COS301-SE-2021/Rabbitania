using System.Net;

namespace backend_api.Models.Booking.Responses
{
    public class CreateBookingScheduleResponse
    {
        private bool successful;

        public CreateBookingScheduleResponse(bool successful)
        {
            this.successful = successful;
        }

        public bool Successful
        {
            get => successful;
            set => successful = value;
        }
    }
}
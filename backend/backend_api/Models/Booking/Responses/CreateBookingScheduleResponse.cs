using System.Net;

namespace backend_api.Models.Booking.Responses
{
    public class CreateBookingScheduleResponse
    {
        private bool _successful;

        public CreateBookingScheduleResponse(bool successful)
        {
            this._successful = successful;
        }

        public CreateBookingScheduleResponse()
        {
        }

        public bool Successful
        {
            get => _successful;
            set => _successful = value;
        }
    }
}
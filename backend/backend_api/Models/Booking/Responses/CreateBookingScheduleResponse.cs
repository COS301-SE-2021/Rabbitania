using System.Net;

namespace backend_api.Models.Booking.Responses
{
    public class CreateBookingScheduleResponse
    {
        private bool _successful;
        private string _mess;

        public CreateBookingScheduleResponse(bool successful, string mess)
        {
            this._successful = successful;
            this._mess = mess;
        }

        public CreateBookingScheduleResponse()
        {
        }
        
        public bool Successful
        {
            get => _successful;
            set => _successful = value;
        }

        public string Mess
        {
            get => _mess;
            set => _mess = value;
        }
    }
}
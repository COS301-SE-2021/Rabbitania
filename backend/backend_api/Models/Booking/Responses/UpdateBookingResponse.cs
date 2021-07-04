using System.Net;

namespace backend_api.Models.Booking.Responses
{
    public class UpdateBookingResponse
    {
        /// <summary>
        ///     Will return status code response to confirm if booking
        ///     was indeed updated or not
        ///     + Status code return 200 (Ok)
        ///     + Status code return 400 (Bad request) 
        /// </summary>
        private HttpStatusCode _response;

        public UpdateBookingResponse(HttpStatusCode response)
        {
            _response = response;
        }

        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }
    }
}
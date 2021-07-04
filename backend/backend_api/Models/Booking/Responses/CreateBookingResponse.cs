using System.Net;

namespace backend_api.Models.Booking.Responses
{
    public class CreateBookingResponse
    {
        /// <summary>
        ///     Will return status code response to confirm if a booking
        ///     was indeed created or not
        ///     + Status code return 201 (Created) or
        ///     + Status code return 400 (Bad request) 
        /// </summary>
        private HttpStatusCode _response;

        public CreateBookingResponse(HttpStatusCode response)
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
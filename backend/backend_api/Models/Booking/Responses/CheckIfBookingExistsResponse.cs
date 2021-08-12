using System.Net;

namespace backend_api.Models.Booking.Responses
{
    public class CheckIfBookingExistsResponse
    {
        /// <summary>
        ///     Will return status code response to confirm if a booking
        ///     already exists for a user.
        ///     + Status code return 200 (Ok) or
        ///     + Status code return 400 (Bad request) 
        /// </summary>
        private HttpStatusCode _response;

        public CheckIfBookingExistsResponse(HttpStatusCode response)
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
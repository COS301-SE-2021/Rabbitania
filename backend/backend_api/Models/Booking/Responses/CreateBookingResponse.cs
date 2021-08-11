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

        private string _message;

        public CreateBookingResponse(HttpStatusCode response)
        {
            _response = response;
        }

        public CreateBookingResponse(HttpStatusCode response, string message)
        {
            _response = response;
            _message = message;
        }

        public string Message
        {
            get => _message;
            set => _message = value;
        }

        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }
    }
}
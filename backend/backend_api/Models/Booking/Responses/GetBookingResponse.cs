namespace backend_api.Models.Booking.Responses
{
    public class GetBookingResponse
    {
        /// <summary>
        ///     Will return a response with a booking object
        /// </summary>
        private Booking _booking;

        public GetBookingResponse(Booking booking)
        {
            _booking = booking;
        }

        public Booking Booking
        {
            get => _booking;
            set => _booking = value;
        }
    }
}
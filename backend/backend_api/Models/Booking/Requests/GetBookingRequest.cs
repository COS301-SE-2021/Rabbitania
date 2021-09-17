namespace backend_api.Models.Booking.Requests
{
    public class GetBookingRequest
    {
        private int _bookingID;

        public GetBookingRequest()
        {
        }

        public GetBookingRequest(int bookingId)
        {
            _bookingID = bookingId;
        }

        public int BookingId
        {
            get => _bookingID;
            set => _bookingID = value;
        }
    }
}
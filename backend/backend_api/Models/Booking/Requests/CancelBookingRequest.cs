namespace backend_api.Models.Booking.Requests
{
    public class CancelBookingRequest
    {
        private int _bookingId;
        
        public CancelBookingRequest()
        {
        }

        public CancelBookingRequest(int bookingId)
        {
            _bookingId = bookingId;
        }

        public int BookingId
        {
            get => _bookingId;
            set => _bookingId = value;
        }
    }
}
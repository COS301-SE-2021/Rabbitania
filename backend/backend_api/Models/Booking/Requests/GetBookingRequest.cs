namespace backend_api.Models.Booking.Requests
{
    public class GetBookingRequest
    {
        private int bookingID;

        public GetBookingRequest()
        {
        }

        public GetBookingRequest(int bookingId)
        {
            bookingID = bookingId;
        }

        public int BookingId
        {
            get => bookingID;
            set => bookingID = value;
        }
    }
}
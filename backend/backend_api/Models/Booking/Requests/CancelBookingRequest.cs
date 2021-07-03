namespace backend_api.Models.Booking.Requests
{
    public class CancelBookingRequest
    {
        public int BookingID;
        
        public CancelBookingRequest()
        {
        }

        public CancelBookingRequest(int bookingId)
        {
            BookingID = bookingId;
        }
    }
}
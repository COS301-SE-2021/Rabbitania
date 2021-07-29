using System;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class UpdateBookingRequest
    {
        private int BookingID;
        private DateTime date;
        private float duration;

        public UpdateBookingRequest()
        {
        }

        public UpdateBookingRequest(int bookingId, DateTime _date, float duration)
        {
            BookingID = bookingId;
            date = date;
            duration = duration;
        }

        public int BookingId
        {
            get => BookingID;
            set => BookingID = value;
        }

        public DateTime Date
        {
            get => date;
            set => date = value;
        }

        public float Duration
        {
            get => duration;
            set => duration = value;
        }
    }
}
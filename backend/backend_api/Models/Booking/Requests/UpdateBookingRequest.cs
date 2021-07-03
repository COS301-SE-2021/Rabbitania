using System;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class UpdateBookingRequest
    {
        private int BookingID;
        private DateTime date;
        private float duration;
        private OfficeLocation office;

        public UpdateBookingRequest()
        {
        }

        public UpdateBookingRequest(int bookingId, DateTime _date, float duration, OfficeLocation office)
        {
            BookingID = bookingId;
            date = date;
            duration = duration;
            this.office = office;
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

        public float Duration1
        {
            get => duration;
            set => duration = value;
        }

        public OfficeLocation Office
        {
            get => office;
            set => office = value;
        }
    }
}
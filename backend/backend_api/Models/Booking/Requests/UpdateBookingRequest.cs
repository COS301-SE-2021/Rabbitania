using System;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class UpdateBookingRequest
    {
        private int BookingID;
        private string date;
        private float duration;
        private string timeSlot;
        private OfficeLocation office;

        public UpdateBookingRequest()
        {
        }

        public UpdateBookingRequest(int bookingId, string date, float duration, string timeSlot, OfficeLocation office)
        {
            BookingID = bookingId;
            this.date = date;
            this.duration = duration;
            this.timeSlot = timeSlot;
            this.office = office;
        }

        public string TimeSlot
        {
            get => timeSlot;
            set => timeSlot = value;
        }

        public OfficeLocation Office
        {
            get => office;
            set => office = value;
        }

        public int BookingId
        {
            get => BookingID;
            set => BookingID = value;
        }

        public string Date
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
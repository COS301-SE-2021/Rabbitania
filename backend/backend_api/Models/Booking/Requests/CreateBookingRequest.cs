using System;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class CreateBookingRequest
    {
        private int userID;
        private float duration;
        private DateTime date;
        private OfficeLocation office;
        
        public CreateBookingRequest()
        {
            
        }
        public CreateBookingRequest(int userId, float duration, DateTime date, OfficeLocation office)
        {
            userID = userId;
            this.duration = duration;
            this.date = date;
            this.office = office;
        }

        public int UserId
        {
            get => userID;
            set => userID = value;
        }

        public float Duration
        {
            get => duration;
            set => duration = value;
        }

        public DateTime Date
        {
            get => date;
            set => date = value;
        }

        public OfficeLocation Office
        {
            get => office;
            set => office = value;
        }
    }
}
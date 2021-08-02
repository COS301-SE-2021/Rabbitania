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
        private string timeSlot;
        
        public CreateBookingRequest()
        {
            
        }
        public CreateBookingRequest(int userId, float duration, DateTime date, OfficeLocation office, string _timeSlot)
        {
            userID = userId;
            this.duration = duration;
            this.date = date;
            this.office = office;
            this.timeSlot = _timeSlot;
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

        public string TimeSlot
        {
            get => timeSlot;
            set => timeSlot = value;
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
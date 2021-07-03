using System;

namespace backend_api.Models.Booking.Requests
{
    public class GetAllBookingsRequest
    {
        private int userID;
        private DateTime date;

        public GetAllBookingsRequest(DateTime date)
        {
            this.date = date;
        }

        public GetAllBookingsRequest(int userId, DateTime date)
        {
            userID = userId;
            this.date = date;
        }

        public DateTime Date
        {
            get => date;
            set => date = value;
        }

        public GetAllBookingsRequest()
        {
        }

        public GetAllBookingsRequest(int userId)
        {
            userID = userId;
        }

        public int UserId
        {
            get => userID;
            set => userID = value;
        }
    }
}
using System;

namespace backend_api.Models.Booking.Requests
{
    public class GetAllBookingsRequest
    {
        private int _userId;
        
        public GetAllBookingsRequest(int userId)
        {
            _userId = userId;
        }

        public GetAllBookingsRequest()
        {
        }

        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }
    }
}
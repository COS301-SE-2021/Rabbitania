using System.Collections.Generic;

namespace backend_api.Models.Booking.Responses
{
    public class GetAllBookingsResponse
    {
        /// <summary>
        ///     Will return a response with a list of bookings
        /// </summary>
        private IEnumerable<Booking> _bookings;
        
        public GetAllBookingsResponse(IEnumerable<Booking> notifications)
        {
            this._bookings = notifications;
        }

        public IEnumerable<Booking> Bookings
        {
            get => _bookings;
            set => _bookings = value;
        }
    }
}
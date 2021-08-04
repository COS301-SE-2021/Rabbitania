using System.Net;

namespace backend_api.Models.Booking.Responses
{
    public class CancelBookingScheduleResponse
    {
        /// <summary>
        ///     Will return bool response to confirm if a booking
        ///     schedule was indeed cancelled or not
        ///     + boole return true (success) or
        ///     + bool return false (failed) 
        /// </summary>
        private bool _response;

        public CancelBookingScheduleResponse(bool response)
        {
            _response = response;
        }

        public bool Response
        {
            get => _response;
            set => _response = value;
        }
    }
}
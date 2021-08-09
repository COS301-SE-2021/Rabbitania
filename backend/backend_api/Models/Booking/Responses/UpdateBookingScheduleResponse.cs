namespace backend_api.Models.Booking.Responses
{
    public class UpdateBookingScheduleResponse
    {
        
        /// <summary>
        ///     Will return a bool value to confirm if booking schedule
        ///     was indeed updated or not
        ///     + return true (Ok)
        ///     + return false (Bad request) 
        /// </summary>
        
        private bool _success;

        public UpdateBookingScheduleResponse(bool success)
        {
            _success = success;
        }

        public bool Success
        {
            get => _success;
            set => _success = value;
        }
    }
}
namespace backend_api.Models.Booking.Responses
{
    public class CheckScheduleAvailabilityResponse
    {
        private bool _successful;

        public CheckScheduleAvailabilityResponse(bool successful)
        {
            this._successful = successful;
        }

        public CheckScheduleAvailabilityResponse()
        {
        }

        public bool Successful
        {
            get => _successful;
            set => _successful = value;
        }
    }
}
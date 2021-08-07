namespace backend_api.Models.Booking.Responses
{
    public class CheckScheduleAvailabilityResponse
    {
        private bool successful;

        public CheckScheduleAvailabilityResponse(bool successful)
        {
            this.successful = successful;
        }

        public CheckScheduleAvailabilityResponse()
        {
        }

        public bool Successful
        {
            get => successful;
            set => successful = value;
        }
    }
}
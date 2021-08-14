using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class GetAllBookingSchedulesRequest
    {
        private OfficeLocation office;
        // private string timeSlot;

        public GetAllBookingSchedulesRequest()
        {
        }

        public GetAllBookingSchedulesRequest(OfficeLocation office)
        {
            this.office = office;
        }

        public OfficeLocation Office
        {
            get => office;
            set => office = value;
        }

        
    }
}
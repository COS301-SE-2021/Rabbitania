using System.Threading.Tasks;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;

namespace backend_api.Services.Booking
{
    public class BookingService: IBookingService
    {
        
        public Task<CreateBookingResponse> CreateBooking(CreateBookingRequest request)
        {
            
        }

    }
}
using System.Threading.Tasks;
using backend_api.Models.Booking.Requests;

namespace backend_api.Services.Booking
{
    public interface IBookingService
    {
        Task<CreateBookingResponse> CreateBooking(CreateBookingRequest request);
    }
}
using System.Threading.Tasks;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;

namespace backend_api.Services.Booking
{
    public interface IBookingService
    {
        Task<CreateBookingResponse> CreateBooking(CreateBookingRequest request);
        
        Task<CancelBookingResponse> CancelBooking(CancelBookingRequest request);
        
        Task<UpdateBookingResponse> UpdateBooking(UpdateBookingRequest request);
        
        Task<GetBookingResponse> ViewBooking(GetBookingRequest request);
        
        Task<GetAllBookingsResponse> ViewAllBookings(GetAllBookingsRequest request);
    }
}
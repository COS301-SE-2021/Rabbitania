using System.Threading.Tasks;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;

namespace backend_api.Services.Booking
{
    public interface IBookingScheduleService
    {
        Task<CreateBookingScheduleResponse> CreateBookingSchedule(CreateBookingScheduleRequest request);
        
        Task<CancelBookingScheduleResponse> CancelBookingSchedule(CancelBookingScheduleRequest request);
        
        Task<UpdateBookingScheduleResponse> UpdateBookingSchedule(UpdateBookingScheduleRequest request);

        Task<GetBookingScheduleResponse> ViewBookingSchedule(GetBookingScheduleRequest request);

        Task<GetAllBookingSchedulesResponse> ViewAllBookingSchedules(GetAllBookingSchedulesRequest request);

    }
}
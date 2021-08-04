using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Booking;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;

namespace backend_api.Data.Booking
{
    public interface IBookingScheduleRepository
    {
        Task<GetBookingScheduleResponse> GetBookingSchedule(GetBookingRequest request);
        Task<GetAllBookingSchedulesResponse> GetAllBookingSchedules(GetAllBookingSchedulesRequest request);
        Task<CancelBookingScheduleResponse> CancelBookingSchedule(CancelBookingScheduleRequest request);
        Task<UpdateBookingScheduleResponse> UpdateBookingSchedule(UpdateBookingScheduleRequest request);
        Task<CreateBookingScheduleResponse> CreateBookingSchedule(CreateBookingScheduleRequest request);
    }
}
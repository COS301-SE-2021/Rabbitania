using System.Threading.Tasks;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;

namespace backend_api.Services.Booking
{
    public interface IBookingScheduleService
    {
        /// <summary>
        ///     Create bookingSchedule service that checks the request object
        ///     and makes sure all checks pass
        /// </summary>
        /// <param name="request"></param>
        /// <returns> CreateBookingScheduleResponse </returns>
        Task<CreateBookingScheduleResponse> CreateBookingSchedule(CreateBookingScheduleRequest request);
        
        Task<CancelBookingScheduleResponse> CancelBookingSchedule(CancelBookingScheduleRequest request);
        
        Task<UpdateBookingScheduleResponse> UpdateBookingSchedule(UpdateBookingScheduleRequest request);

        Task<GetBookingScheduleResponse> ViewBookingSchedule(GetBookingScheduleRequest request);

        Task<GetAllBookingSchedulesResponse> ViewAllBookingSchedules(GetAllBookingSchedulesRequest request);

        Task<CheckScheduleAvailabilityResponse> CheckAvailability(CheckScheduleAvailabilityRequest request);
    }
}
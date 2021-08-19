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
        /// <param name="request"> CreateBookingScheduleRequest </param>
        /// <returns> CreateBookingScheduleResponse </returns>
        Task<CreateBookingScheduleResponse> CreateBookingSchedule(CreateBookingScheduleRequest request);
        
        /// <summary>
        ///     This service checks whether or not a request can be processed to return a list of
        ///     all schedules currently. Returns a list of schedules as a response.
        /// </summary>
        /// <param name="request"> GetAllBookingSchedulesRequest </param>
        /// <returns> GetAllBookingSchedulesResponse </returns>
        Task<GetAllBookingSchedulesResponse> ViewAllBookingSchedules(GetAllBookingSchedulesRequest request);
        
        /// <summary>
        ///     A service to check whether or not a schedule is available or not.
        /// </summary>
        /// <param name="request"> CheckScheduleAvailabilityRequest </param>
        /// <returns> CreateBookingScheduleResponse </returns>
        Task<CheckScheduleAvailabilityResponse> CheckAvailability(CheckScheduleAvailabilityRequest request);
        
        /// <summary>
        ///     Service to check whether the request being passed through is valid and makes
        ///     a call to the update booking repository. A response is return if all
        ///     checks pass.
        /// </summary>
        /// <param name="request"> UpdateBookingScheduleRequest </param>
        /// <returns> CreateBookingScheduleResponse </returns>
        Task<UpdateBookingScheduleResponse> UpdateBookingSchedule(UpdateBookingScheduleRequest request);
        
        /// <summary>
        ///     Returns a GetBookingScheduleResponse if the request is valid or not, if so
        ///     a GetBookingScheduleResponse is returned.
        /// </summary>
        /// <param name="request"> GetBookingScheduleRequest </param>
        /// <returns> CreateBookingScheduleResponse </returns>
        Task<GetBookingScheduleResponse> ViewBookingSchedule(GetBookingScheduleRequest request);
        
        
        /// <summary>
        ///     Cancel booking schedule deletes a booking schedule where necessary.
        ///     returns a response if the request can be processed or not
        /// </summary>
        /// <param name="request"> CancelBookingScheduleRequest </param>
        /// <returns> CreateBookingScheduleResponse </returns>
        Task<CancelBookingScheduleResponse> CancelBookingSchedule(CancelBookingScheduleRequest request);
    }
}
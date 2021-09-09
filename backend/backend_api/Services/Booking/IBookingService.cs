using System.Net;
using System.Threading.Tasks;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;

namespace backend_api.Services.Booking
{
    public interface IBookingService
    {
        /// <summary>
        ///     Create booking object that checks the request object
        ///     and makes sure all checks pass
        /// </summary>
        /// <param name="request"></param>
        /// <returns> CreateBookingResponse </returns>
        Task<CreateBookingResponse> CreateBooking(CreateBookingRequest request);
        
        /// <summary>
        ///     Creating a service that cancels a booking on
        ///     request and then returns an appropriate response
        /// </summary>
        /// <param name="request"></param>
        /// <returns> CancelBookingResponse </returns>
        Task<CancelBookingResponse> CancelBooking(CancelBookingRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid
        ///     returns thereafter a List of notifications of
        ///     the notifications as a response.
        /// </summary>
        /// <param name="request"></param>
        /// <returns> GetAllBookingsResponse </returns>
        Task<GetAllBookingsResponse> ViewAllBookings(GetAllBookingsRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid
        ///     returns thereafter a List of notifications of
        ///     the notifications.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>List of Notifications for user.</returns>
        Task<GetBookingResponse> ViewBooking(GetBookingRequest request);
        
        /// <summary>
        ///     Checks whether or not a booking can be made. If a booking
        ///     Can be made a response is return with the appropriate boolean
        ///     value of either true or false as a response
        /// </summary>
        /// <param name="request"></param>
        /// <returns> CheckIfBookingExistsResponse </returns>
        Task<CheckIfBookingExistsResponse> CheckIfBookingExists(CheckIfBookingExistsRequest request);
        
        /// <summary>
        ///     Updates a booking for the user, a booking will not be updated
        ///     a lot, but an update may occur on the system.
        /// </summary>
        /// <param name="request"></param>
        /// <returns> UpdateBookingResponse </returns>
        Task<UpdateBookingResponse> UpdateBooking(UpdateBookingRequest request);
    }
}
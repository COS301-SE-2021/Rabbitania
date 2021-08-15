using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;
using Microsoft.AspNetCore.Mvc;


namespace backend_api.Data.Booking
{
    public interface IBookingRepository
    { 
        Task<Models.Booking.Booking> GetBooking(GetBookingRequest request);
        
        Task<IEnumerable<Models.Booking.Booking>> GetAllBookings(GetAllBookingsRequest request);

        Task<HttpStatusCode> CancelBooking(CancelBookingRequest request);

        Task<HttpStatusCode> UpdateBooking(UpdateBookingRequest request);

        Task<HttpStatusCode> CreateBooking(CreateBookingRequest request);

        Task<HttpStatusCode> CheckIfBookingExists(CheckIfBookingExistsRequest request);

    }
}
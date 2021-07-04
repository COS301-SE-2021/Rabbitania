using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Exceptions.Booking;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;
using backend_api.Services.Booking;
using backend_api.Services.User;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace backend_api.Controllers.Booking
{
    [AllowAnonymous, Route("api/[controller]")]
    [ApiController]
    public class BookingController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly IBookingService _bookingService;

        public BookingController(IUserService userService, IBookingService bookingService)
        {
            _userService = userService;
            _bookingService = bookingService;
        }
        
        /// <summary>
        ///     API endpoint for retrieving bookings belonging to a user
        ///     Checks if the given request is valid and then queries the service
        ///     If the user cannot be found an InvalidBookingException is thrown
        ///     An Http response code is returned.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Http response code and json object</returns>
        [HttpGet]
        [Route("GetBookings")]
        public async Task<ActionResult> GetAllBookings([FromQuery] GetAllBookingsRequest request)
        {
            if (request != null)
            {
                try
                {
                    var bookings = await _bookingService.ViewAllBookings(request);
                    var list = bookings.Bookings.ToList();
                    return Ok(list);
                }
                catch (InvalidBookingException e)
                {
                    throw e;
                }
                
            }
            else
            {
                return BadRequest("Request is null or empty");
            }
            
        }
        /// <summary>
        ///     API endpoint for retrieving a booking with a bookingID
        ///     Checks if the given request is valid and then queries the service
        ///     If the Booking cannot be found an InvalidBookingException is thrown
        ///     response code is returned.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Http response code and json object</returns>
        [HttpGet]
        [Route("GetBooking")]
        public async Task<ActionResult> GetBooking([FromQuery] GetBookingRequest request)
        {
            if (request != null)
            {
                try
                {
                    var booking = await _bookingService.ViewBooking(request);
                    var json = JsonConvert.SerializeObject(booking);
                    return Ok(json);
                }
                catch (InvalidBookingException e)
                {
                    throw e;
                }
                
            }
            else
            {
                return BadRequest("Request is null or empty");
            }
            
        }
    }
}

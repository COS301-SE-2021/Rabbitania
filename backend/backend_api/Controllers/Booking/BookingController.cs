using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
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
        ///     If the User cannot be found an InvalidBookingException is thrown
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

        /// <summary>
        ///     API endpoint for updating a Booking with a BookingID
        ///     Checks if the given request is valid and then queries the service
        ///     If the Booking to update cannot be found, an InvalidBookingException is thrown
        ///     An Http response code is returned.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Http response code</returns>
        [HttpPut]
        [Route("EditBooking")]
        public async Task<ActionResult> UpdateBooking([FromQuery] UpdateBookingRequest request)
        {
            if (request != null)
            {
                try
                {
                    var resp = await _bookingService.UpdateBooking(request);
                    if (resp.Response == HttpStatusCode.Accepted)
                    {
                        return Ok("Successfully updated booking "+request.BookingId);
                    }
                    else
                    {
                        return BadRequest("Error when trying to update booking with ID: "+request.BookingId);
                    }
                }
                catch (InvalidBookingException e)
                {
                    throw;
                }
            }
            else
            {
                return BadRequest("Request is null or empty");
            }
        }
        
        /// <summary>
        ///     API endpoint for deleting a Booking with a BookingID
        ///     Checks if the given request is valid and then queries the service
        ///     If the Booking to delete cannot be found, an InvalidBookingException is thrown
        ///     An Http response code is returned.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Http response code</returns>
        [HttpDelete]
        [Route("DeleteBooking")]
        public async Task<ActionResult> DeleteBooking([FromQuery] CancelBookingRequest request)
        {
            if (request != null)
            {
                try
                {
                    var resp = await _bookingService.CancelBooking(request);
                    if (resp.Response == HttpStatusCode.Accepted)
                    {
                        return Ok("Booking with ID: "+request.BookingId+" successfully deleted.");
                    }
                    else
                    {
                        return BadRequest("Error trying to delete booking with ID: "+request.BookingId+" from the database.");
                    }
                }
                catch (InvalidBookingException)
                {
                    throw;
                }
            }
            else
            {
                return BadRequest("Request is null or empty");
            }
        }
        
        /// <summary>
        ///     API endpoint for creating a Booking
        ///     Checks if the given request is valid and then queries the service
        ///     If the new Booking cannot be created in the database, an InvalidBookingException is thrown
        ///     An Http response code is returned.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Http response code</returns>
        [HttpPost]
        [Route("CreateBooking")]
        public async Task<ActionResult> CreateBooking([FromBody] CreateBookingRequest request)
        {
            if (request != null)
            {
                try
                {
                    var resp = await _bookingService.CreateBooking(request);
                    if (resp.Response == HttpStatusCode.Created)
                    {
                        return Ok("Booking created successfully");
                    }
                    else
                    {
                        return BadRequest("Error trying to create booking in system");
                    }
                }
                catch (Exception)
                {
                    throw;
                }
            }
            else
            {
                return BadRequest("Request is null or empty");
            }
        }

        /*public async Task<ActionResult> CheckIfBookingExists([FromBody] CreateBookingRequest request)
        {
            
        }*/
        
    }
}
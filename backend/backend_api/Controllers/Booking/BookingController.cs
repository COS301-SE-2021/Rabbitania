using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
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
        
        // GET: api/GetBookings
        [HttpGet]
        [Route("GetBookings")]
        public async Task<ActionResult> GetAllBookings([FromQuery] GetAllBookingsRequest request)
        {
            if (request != null)
            {
                var bookings = await _bookingService.ViewAllBookings(request);
                var list = bookings.Bookings.ToList();
                return Ok(list);
            }
            else
            {
                return BadRequest("Request is null or empty");
            }
            
        }

       

        // POST: api/Booking
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT: api/Booking/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE: api/Booking/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}

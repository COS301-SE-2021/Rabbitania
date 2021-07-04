using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Models.Booking.Requests;
using backend_api.Services.User;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace backend_api.Controllers.Booking
{
    [AllowAnonymous, Route("api/[controller]")]
    [ApiController]
    public class BookingController : ControllerBase
    {
        private readonly IUserService _userService;
        //private readonly IBookingService _bookingService;

        public BookingController(IUserService userService)
        {
            _userService = userService;
            //_bookingService = _bookingService;
        }
        
        // GET: api/Booking
        [HttpGet]
        [Route("GetBookings")]
        // public GetAllBookingsResponse GetAllBookings([FromQuery] GetAllBookingsRequest request)
        // {
        //     return _bookingService.getAllBookings(request);
        // }

        // GET: api/Booking/5
        [HttpGet("{id}", Name = "Get")]
        public string Get(int id)
        {
            return "value";
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
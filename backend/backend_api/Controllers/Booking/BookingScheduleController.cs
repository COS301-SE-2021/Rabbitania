using System.Linq;
using System.Threading.Tasks;
using backend_api.Exceptions.Booking;
using backend_api.Models.Booking.Requests;
using backend_api.Services.Booking;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace backend_api.Controllers.Booking
{
    [AllowAnonymous, Route("api/[controller]")]
    [ApiController]
    public class BookingScheduleController : ControllerBase
    {
        private readonly IBookingScheduleService _scheduleService;

        private readonly IBookingService _bookingService;

        public BookingScheduleController(IBookingScheduleService scheduleService, IBookingService bookingService)
        {
            _scheduleService = scheduleService;
            _bookingService = bookingService;
        }

        public BookingScheduleController(IBookingScheduleService scheduleService)
        {
            _scheduleService = scheduleService;
        }

        /// <summary>
        ///     API endpoint for retrieving booking schedules belonging to an office
        ///     Checks if the given request is valid and then queries the service
        ///     An Http response code is returned.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Http response code and list object</returns>
        [HttpGet]
        [Route("GetBookingSchedules")]
        public async Task<ActionResult> GetAllBookingSchedules([FromQuery] GetAllBookingSchedulesRequest request)
        {
            if (request != null)
            {
                try
                {
                    var schedules = await _scheduleService.ViewAllBookingSchedules(request);
                    var list = schedules.BookingSchedules.ToList();
                    return Ok(JsonConvert.SerializeObject(list));
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
        // <summary>
                ///     API endpoint for retrieving a booking with a bookingID
                ///     Checks if the given request is valid and then queries the service
                ///     If the Booking cannot be found an InvalidBookingException is thrown
                ///     response code is returned.
                /// </summary>
                /// <param name="request"></param>
                /// <returns>Http response code and json object</returns>
                [HttpGet]
                [Route("GetBookingSchedule")]
                public async Task<ActionResult> GetBookingSchedule([FromQuery] GetBookingScheduleRequest request)
                {
                    if (request != null)
                    {
                        try
                        {
                            var booking = await _scheduleService.ViewBookingSchedule(request);
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
using System;
using System.Linq;
using System.Net;
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
                ///     API endpoint for retrieving a booking schedule with a office and timeslot
                ///     Checks if the given request is valid and then queries the service
                ///     If the Booking schedule cannot be found an InvalidBookingException is thrown
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
                /// <summary>
                        ///     API endpoint for updating a Booking schedule
                        ///     Checks if the given request is valid and then queries the service
                        ///     If the Booking schedule to update cannot be found, an InvalidBookingException is thrown
                        ///     An Http response code is returned.
                        /// </summary>
                        /// <param name="request"></param>
                        /// <returns>Http response code</returns>
                        [HttpPut]
                        [Route("EditBookingSchedule")]
                        public async Task<ActionResult> UpdateBookingSchedule([FromQuery] UpdateBookingScheduleRequest request)
                        {
                            if (request != null)
                            {
                                try
                                {
                                    var resp = await _scheduleService.UpdateBookingSchedule(request);
                                    if (resp.Success == true)
                                    {
                                        return Ok("Successfully updated booking schedule");
                                    }
                                    else
                                    {
                                        return BadRequest("Error when trying to update booking schedule");
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
                ///     API endpoint for deleting a Booking Schedule
                ///     Checks if the given request is valid and then queries the service
                ///     If the Booking schedule to delete cannot be found, an InvalidBookingException is thrown
                ///     An Http response code is returned.
                /// </summary>
                /// <param name="request"></param>
                /// <returns>Http response code</returns>
                [HttpDelete]
                [Route("DeleteBookingSchedule")]
                public async Task<ActionResult> DeleteBookingSchedule([FromQuery] CancelBookingScheduleRequest request)
                {
                    if (request != null)
                    {
                        try
                        {
                            var resp = await _scheduleService.CancelBookingSchedule(request);
                            if (resp.Response == true)
                            {
                                return Ok("Booking Schedule for: "+request.Office+", "+request.TimeSlot+" successfully deleted.");
                            }
                            else
                            {
                                return BadRequest("Error trying to delete booking schedule for: "+request.Office+", "+request.TimeSlot+" from the database.");
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
                ///     API endpoint for creating a Booking Schedule
                ///     Checks if the given request is valid and then queries the service
                ///     If the new Booking Schedule cannot be created in the database, an InvalidBookingException is thrown
                ///     An Http response code is returned.
                /// </summary>
                /// <param name="request"></param>
                /// <returns>Http response code</returns>
                [HttpPost]
                [Route("CreateBooking")]
                public async Task<ActionResult> CreateBookingSchedule([FromBody] CreateBookingScheduleRequest request)
                {
                    if (request != null)
                    {
                        try
                        {
                            var resp = await _scheduleService.CreateBookingSchedule(request);
                            if (resp.Successful == true)
                            {
                                return Ok("Booking Schedule created successfully");
                            }
                            else
                            {
                                return BadRequest("Error trying to create booking Schedule in system");
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
                /// <summary>
                ///     API endpoint for checking the availability of a booking schedule
                ///     Checks if the given request is valid and then queries the service
                ///     If the schedule has availability, 1 is deducted and the database is updated
                ///     A bool is returned.
                /// </summary>
                /// <param name="request"></param>
                /// <returns>bool</returns>
                [HttpGet]
                [Route("CheckAvailability")]
                public async Task<bool> CheckBookingAvailabilityEndpoint([FromBody] CheckScheduleAvailabilityRequest request)
                {
                    if (request != null)
                    {
                        try
                        {
                            var resp = await _scheduleService.CheckAvailability(request);
                            if (resp.Successful == true)
                            {
                                return true;
                            }
                            else
                            {
                                return false;
                            }
                        }
                        catch (Exception)
                        {
                            throw;
                        }
                    }
                    else
                    {
                        return false;
                    }
                }
    }
}
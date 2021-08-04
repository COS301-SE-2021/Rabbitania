using System;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Models.Booking;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Booking
{
    public class BookingScheduleRepository: IBookingScheduleRepository
    {
        private readonly BookingScheduleContext _schedules;
        private readonly BookingContext _bookings;

        public BookingScheduleRepository(BookingScheduleContext schedules)
        {
            _schedules = schedules;
        }

        public BookingScheduleRepository(BookingScheduleContext schedules, BookingContext bookings)
        {
            _schedules = schedules;
            _bookings = bookings;
        }
        
        //return a booking schedule for a specific office
        //Not quite sure about how this will be used
        public async Task<GetBookingScheduleResponse> GetBookingSchedule(GetBookingScheduleRequest request)
        {
            //var timeSlot = request.TimeSlot;
            var bookingSchedule = _schedules.BookingSchedules.Select(
                s => new {
                    s.Office,
                    s.TimeSlot,
                    s.Availability
                }).FirstOrDefaultAsync();
            var resp = new GetBookingScheduleResponse(new BookingSchedule(bookingSchedule.Result.TimeSlot, bookingSchedule.Result.Office, bookingSchedule.Result.Availability));
            return resp;
        }

        public async Task<GetAllBookingSchedulesResponse> GetAllBookingSchedules(GetAllBookingSchedulesRequest request)
        {
            var schedules = await _schedules.BookingSchedules.Where(s => s.Office == request.Office).ToListAsync();
            return new GetAllBookingSchedulesResponse(schedules);
        }

        public async Task<CancelBookingScheduleResponse> CancelBookingSchedule(CancelBookingScheduleRequest request)
        {
            var bookingSchedule = _schedules.BookingSchedules.Select(
                s => new {
                    s.Office,
                    s.TimeSlot,
                    s.Availability
                }).FirstOrDefaultAsync();
            var scheduleToRemove = new BookingSchedule(bookingSchedule.Result.TimeSlot, bookingSchedule.Result.Office,
                bookingSchedule.Result.Availability);
            try
            {
                _schedules.BookingSchedules.Remove(scheduleToRemove);
                await _schedules.SaveChangesAsync();
            }
            catch (Exception e)
            {
                return new CancelBookingScheduleResponse(false);
            }
        }

        
    }
}
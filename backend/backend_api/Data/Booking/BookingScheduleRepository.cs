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

        //return a booking schedule for a specific office
        //Not quite sure about how this will be used
        public async Task<GetBookingScheduleResponse> GetBookingSchedule(GetBookingScheduleRequest request)
        {
            var bookingSchedule = await _schedules.BookingSchedules.FindAsync(
                request.Office, request.TimeSlot).AsTask();
            var resp = new GetBookingScheduleResponse(new BookingSchedule(bookingSchedule.TimeSlot, bookingSchedule.Office, bookingSchedule.Availability));
            return resp;
        }

        public async Task<GetAllBookingSchedulesResponse> GetAllBookingSchedules(GetAllBookingSchedulesRequest request)
        {
            var schedules = await _schedules.BookingSchedules.Where(s => s.Office == request.Office).ToListAsync();
            return new GetAllBookingSchedulesResponse(schedules);
        }

        public async Task<CancelBookingScheduleResponse> CancelBookingSchedule(CancelBookingScheduleRequest request)
        {
            var bookingSchedule = await _schedules.BookingSchedules.FindAsync(
                request.Office, request.TimeSlot).AsTask();
            var scheduleToRemove = new BookingSchedule(bookingSchedule.TimeSlot, bookingSchedule.Office,
                bookingSchedule.Availability);
            try
            {
                _schedules.BookingSchedules.Remove(scheduleToRemove);
                await _schedules.SaveChangesAsync();
                if (_schedules.Entry(scheduleToRemove).State == EntityState.Deleted)
                    return new CancelBookingScheduleResponse(true);
                else
                {
                    return new CancelBookingScheduleResponse(false);
                }
            }
            catch (Exception)
            {
                return new CancelBookingScheduleResponse(false);
            }
        }
        public async Task<UpdateBookingScheduleResponse> UpdateBookingSchedule(UpdateBookingScheduleRequest request)
        {
            var bookingSchedule = await _schedules.BookingSchedules.FindAsync(
                request.Office, request.TimeSlot).AsTask();
            var scheduleToUpdate = new BookingSchedule(bookingSchedule.TimeSlot, bookingSchedule.Office,
                bookingSchedule.Availability);
            //setting new values
            scheduleToUpdate.Availability = request.Availability;
            scheduleToUpdate.Office = request.Office;
            scheduleToUpdate.TimeSlot = request.TimeSlot;
            try
            {
                _schedules.Entry(scheduleToUpdate).State = EntityState.Modified;
                await _schedules.SaveChangesAsync();
                return new UpdateBookingScheduleResponse(true);
            }
            catch (Exception)
            {
                return new UpdateBookingScheduleResponse(false);
            }
            
        }
        public async Task<UpdateBookingScheduleResponse> UpdateBookingScheduleAvailability(UpdateBookingScheduleRequest request)
        {
            var bookingSchedule = await _schedules.BookingSchedules.FindAsync(
                request.Office, request.TimeSlot).AsTask();
            var scheduleToUpdate = new BookingSchedule(bookingSchedule.TimeSlot, bookingSchedule.Office,
                bookingSchedule.Availability);
            //setting new values
            scheduleToUpdate.Availability = request.Availability;
            try
            {
                _schedules.Entry(scheduleToUpdate).State = EntityState.Modified;
                await _schedules.SaveChangesAsync();
                return new UpdateBookingScheduleResponse(true);
            }
            catch (Exception)
            {
                return new UpdateBookingScheduleResponse(false);
            }
            
        }

        public async Task<CreateBookingScheduleResponse> CreateBookingSchedule(CreateBookingScheduleRequest request)
        {
            var newSchedule = new BookingSchedule(request.TimeSlot, request.Office, request.Availability);
            try
            {
                await _schedules.BookingSchedules.AddAsync(newSchedule);
                await _schedules.SaveChangesAsync();
                return new CreateBookingScheduleResponse(true);
            }
            catch (Exception)
            {
                return new CreateBookingScheduleResponse(false);
            }
        }



        
    }
}
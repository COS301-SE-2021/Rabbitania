using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;
using backend_api.Models.User;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;


namespace backend_api.Data.Booking
{
    public class BookingRepository: IBookingRepository
    {
        private readonly BookingContext _bookings;
        private readonly UserContext _users;

        public BookingRepository(BookingContext bookings)
        {
            _bookings = bookings;
        }

        public BookingRepository(BookingContext bookings, UserContext users)
        {
            _bookings = bookings;
            _users = users;
        }

        public async Task<Models.Booking.Booking> GetBooking(GetBookingRequest request)
        {
            var bookingID = request.BookingId;
            var resp =  await _bookings.Bookings.FirstOrDefaultAsync(x => x.BookingId == bookingID);
            return resp;
        }
        
        public async Task<IEnumerable<Models.Booking.Booking>> GetAllBookings(GetAllBookingsRequest request)
        {
            var userID = request.UserId;
            return await _bookings.Bookings.Where(x => x.UserId == userID).ToListAsync();
        }

        public async Task<HttpStatusCode> CancelBooking(CancelBookingRequest request)
        {
            var booking = await _bookings.Bookings.FirstOrDefaultAsync(x => x.BookingId == request.BookingId);
            try
            {
                //_bookings.Bookings.Remove(booking);
                _bookings.Entry(booking).State = EntityState.Deleted;
                var deleted = await _bookings.SaveChangesAsync();
                if (deleted >= 0)
                    return HttpStatusCode.Accepted;
                else
                    return HttpStatusCode.NotFound;
            }
            catch (Exception)
            {
                return HttpStatusCode.BadRequest;

            }
        }

        public async Task<HttpStatusCode> UpdateBooking(UpdateBookingRequest request)
        {
            var bookingID = request.BookingId;
            var toUpdate = await _bookings.Bookings.FindAsync(bookingID).AsTask();
            try
            {
                toUpdate.Office = request.Office;
                toUpdate.TimeSlot = request.TimeSlot;
                toUpdate.BookingDate = request.Date;
                // _bookings.Entry(toUpdate).State = EntityState.Modified;
                await _bookings.SaveChangesAsync();
                return HttpStatusCode.Accepted;
            }
            catch(Exception)
            {
                return HttpStatusCode.BadRequest;
               
            }
        }

        public async Task<HttpStatusCode> CreateBooking(CreateBookingRequest request)
        {
            var bookingDate = request.BookingDate;
            var bookingOffice = request.Office;
            var timeSlot = request.TimeSlot;
            var user = _users.Users.Where(x => x.UserId == request.UserId);
            
            
            var bookingUserId = request.UserId;
            var booking = new Models.Booking.Booking(bookingDate, timeSlot, bookingOffice, bookingUserId);
            try
            {
                await _bookings.Bookings.AddAsync(booking);
                await _bookings.SaveChangesAsync();
                return HttpStatusCode.Created;
            }
            catch(Exception)
            {
                return HttpStatusCode.BadRequest;
            }
        }
        
        public async Task<HttpStatusCode> CheckIfBookingExists(CheckIfBookingExistsRequest request)
        {
            var timeSlot = request.TimeSlot;
            var office = request.Office;
            var userId = request.UserId;
            
            var bookingChecked =  await _bookings.Bookings
                .Where(x => x.UserId == request.UserId)
                .Where(y => y.TimeSlot == request.TimeSlot)
                .Where(z => z.Office == request.Office).ToListAsync();
            
            // No booking therefore all good
            if(!bookingChecked.Any())
            {
                return HttpStatusCode.Accepted;
            }
            
            // Yes there is a booking already
            return HttpStatusCode.BadRequest; 
        }
    }
}
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
                _bookings.Bookings.Remove(booking);
                await _bookings.SaveChanges();
                if (_bookings.Entry(booking).State == EntityState.Deleted)
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
            var toUpdate = await _bookings.Bookings.FirstOrDefaultAsync(x => x.BookingId == bookingID);
            toUpdate.BookingDate = request.Date;
            try
            {
                _bookings.Entry(toUpdate).State = EntityState.Modified;
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
            var bookingDate = request.Date;
            var bookingDuration = request.Duration;
            var bookingOffice = OfficeLocation.Unassigned;
            var timeSlot = request.TimeSlot;
            var user = _users.Users.Where(x => x.UserId == request.UserId);
            foreach(var y in user)
            {
                bookingOffice = y.OfficeLocation;
            }
            
            var bookingUserID = request.UserId;
            var booking = new Models.Booking.Booking(bookingDate, timeSlot, bookingOffice, bookingUserID);
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
    }
}
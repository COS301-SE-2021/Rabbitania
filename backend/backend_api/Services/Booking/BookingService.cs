﻿using System;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.Booking;
using backend_api.Exceptions.Booking;
using backend_api.Exceptions.Notifications;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;
using Castle.Core.Internal;

namespace backend_api.Services.Booking
{
    public class BookingService: IBookingService
    {
        private readonly IBookingRepository _bookingRepository;

        public BookingService(IBookingRepository bookingRepository)
        {
            _bookingRepository = bookingRepository;
        }

        public async Task<CreateBookingResponse> CreateBooking(CreateBookingRequest request)
        {
            
        }
        public async Task<UpdateBookingResponse> UpdateBooking(UpdateBookingRequest request)
        {
            var resp = await _bookingRepository.UpdateBooking(request);
            if (resp == HttpStatusCode.Accepted)
            {
                return new UpdateBookingResponse(HttpStatusCode.OK);
            }
            else
            {
                return new UpdateBookingResponse(HttpStatusCode.NotFound);
            }
        }

        public async Task<CancelBookingResponse> CancelBooking(CancelBookingRequest request)
        {
            
        }

        public async Task<GetBookingResponse> ViewBooking(GetBookingRequest request)
        {
            var resp = await _bookingRepository.GetBooking(request);
            if (resp!=null)
            {
                return new GetBookingResponse(resp);
            }
            else
            {
                throw new InvalidBookingException("Booking not found");
            }
        }

        public async Task<GetAllBookingsResponse> ViewAllBookings(GetAllBookingsRequest request)
        {
            var resp = await _bookingRepository.GetAllBookings(request);
            if (!resp.IsNullOrEmpty())
            {
                return new GetAllBookingsResponse(resp);
            }
            else
            {
                throw new InvalidBookingException("The specified user: "+request.UserId+" has no bookings");
            }
        }



    }
}

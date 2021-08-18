using System;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.Booking;
using backend_api.Exceptions.Booking;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;
using Castle.Core.Internal;

namespace backend_api.Services.Booking
{
    public class BookingService : IBookingService
    {
        private readonly IBookingRepository _bookingRepository;
        private readonly IBookingScheduleRepository _scheduleRepository;
        private readonly IBookingScheduleService _scheduleService;

        public BookingService(IBookingRepository bookingRepository)
        {
            _bookingRepository = bookingRepository;
        }

        public BookingService(IBookingRepository bookingRepository, IBookingScheduleRepository scheduleService)
        {
            _bookingRepository = bookingRepository;
            _scheduleRepository = scheduleService;
        }

        public BookingService(IBookingRepository bookingRepository, IBookingScheduleRepository scheduleRepository, IBookingScheduleService scheduleService)
        {
            _bookingRepository = bookingRepository;
            _scheduleRepository = scheduleRepository;
            _scheduleService = scheduleService;
        }

        public async Task<CreateBookingResponse> CreateBooking(CreateBookingRequest request)
        {
            if (request == null)
            {
                throw new InvalidBookingException("Request is null or empty");
            }

            if (request.UserId is 0 or < 0)
            {
                throw new InvalidBookingException("Invalid UserId");
            }

            if (request.BookingDate == "")
            {
                throw new InvalidDateException("Date is not in correct format");
            }
            
            //Whole day booking
            if (request.TimeSlot.Split(',')[1].ToLower() == "whole")
            {
                var day = request.TimeSlot.Split(',')[0];
                var booking1 = day + ",Morning";
                var booking2 = day + ",Afternoon";

                var req1 = new CreateBookingRequest(request.BookingDate, booking1, request.Office, request.UserId);
                var req2 = new CreateBookingRequest(request.BookingDate, booking2, request.Office, request.UserId);

                var availability1 = await _scheduleService.CheckAvailability( new CheckScheduleAvailabilityRequest(booking1, request.Office));
                var availability2 = await _scheduleService.CheckAvailability( new CheckScheduleAvailabilityRequest(booking2, request.Office));
                
                if (availability1.Successful && availability2.Successful)
                {
                    var res1 = await _bookingRepository.CreateBooking(req1);
                    var res2 = await _bookingRepository.CreateBooking(req2);
                
                    if (res1 == HttpStatusCode.Created && res2 == HttpStatusCode.Created)
                    {
                        await _scheduleRepository.UpdateBookingScheduleAvailability(new UpdateBookingScheduleRequest(booking1, request.Office));
                        await _scheduleRepository.UpdateBookingScheduleAvailability(new UpdateBookingScheduleRequest(booking2, request.Office));
                        return new CreateBookingResponse(HttpStatusCode.Created, "Booking created successfully for the whole day.");
                    }
                    else
                    {
                        return new CreateBookingResponse(HttpStatusCode.BadRequest, "Booking creation failed.");
                    }
                }
                else
                {
                    return new CreateBookingResponse(HttpStatusCode.BadRequest, "No available booking slots for whole day booking");
                }
            }
            //booking for single slot
            else
            {
                var availability = await _scheduleService.CheckAvailability( new CheckScheduleAvailabilityRequest(request.TimeSlot, request.Office));
                if (availability.Successful)
                {
                    await _scheduleRepository.UpdateBookingScheduleAvailability(new UpdateBookingScheduleRequest(request.TimeSlot, request.Office));

                    var response = new CreateBookingResponse(
                        await _bookingRepository.CreateBooking(request)
                    );
                    return response;
                }
                else
                {
                    return new CreateBookingResponse(HttpStatusCode.BadRequest, "Booking creation failed for slot "+request.TimeSlot+" at "+request.Office);
                }
            }
            
        }

        public async Task<UpdateBookingResponse> UpdateBooking(UpdateBookingRequest request)
        {
            if (request != null)
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
            else
            {
                throw new InvalidBookingException("request is null or empty");
            }
        }

        public async Task<CancelBookingResponse> CancelBooking(CancelBookingRequest request)
        {
            if (request != null)
            {
                var booking = await _bookingRepository.GetBooking(new GetBookingRequest(request.BookingId));
                var resp = await _bookingRepository.CancelBooking(request);

                var req = new UpdateBookingScheduleRequest(booking.TimeSlot, booking.Office);
                await _scheduleRepository.UpdateBookingScheduleAvailabilityAdd(req);
                
                return new CancelBookingResponse(resp);
            }
            else
            {
                throw new InvalidBookingException("Request is null or empty");
            }
        }

        public async Task<GetBookingResponse> ViewBooking(GetBookingRequest request)
        {
            if (request != null)
            {
                var resp = await _bookingRepository.GetBooking(request);
                if (resp != null)
                {
                    return new GetBookingResponse(resp);
                }
                else
                {
                    throw new InvalidBookingException("Booking not found");
                }
            }
            else
            {
                throw new InvalidBookingException("request is null or empty");
            }
        }

        public async Task<GetAllBookingsResponse> ViewAllBookings(GetAllBookingsRequest request)
        {
            if (request != null)
            {
                var resp = await _bookingRepository.GetAllBookings(request);
                if (!resp.IsNullOrEmpty())
                {
                    return new GetAllBookingsResponse(resp);
                }
                else
                {
                    return new GetAllBookingsResponse(resp);
                }
            }
            else
            {
                throw new InvalidBookingException("Request is null or empty");
            }
        }

        public async Task<CheckIfBookingExistsResponse> CheckIfBookingExists(CheckIfBookingExistsRequest request)
        {
            if (request.UserId is 0 or < 0)
            {
                throw new InvalidBookingException("UserId is invalid wih CheckIfBookingExists method...");
            }

            if (request.TimeSlot is "" or "")
            {
                throw new InvalidBookingException("Invalid Time Slots.");
            }
            
            var resp =  await _bookingRepository.CheckIfBookingExists(request);
            
            return new CheckIfBookingExistsResponse(resp);
        }
    }
}
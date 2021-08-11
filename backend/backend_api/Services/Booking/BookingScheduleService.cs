﻿using System.Threading.Tasks;
using backend_api.Data.Booking;
using backend_api.Exceptions.Booking;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Booking.Responses;
using backend_api.Models.User;

namespace backend_api.Services.Booking
{
    public class BookingScheduleService: IBookingScheduleService
    {
        private readonly IBookingScheduleRepository _scheduleRepository;

        public BookingScheduleService(IBookingScheduleRepository scheduleRepository)
        {
            _scheduleRepository = scheduleRepository;
        }

        public async Task<CreateBookingScheduleResponse> CreateBookingSchedule(CreateBookingScheduleRequest request)
        {
            if (request == null)
            {
                throw new InvalidBookingException("Request is null or empty");
            }
            
            if (request.TimeSlot.Split(',')[1].ToLower() == "whole")
            {
                var day = request.TimeSlot.Split(',')[0];
                var booking1 = day + ",Morning";
                var booking2 = day + ",Afternoon";
                
                var req1 = new CreateBookingScheduleRequest(request.Office, booking1, request.Availability);
                var req2 = new CreateBookingScheduleRequest(request.Office, booking2, request.Availability);
                
                var res1 = await _scheduleRepository.CreateBookingSchedule(req1);
                var res2 = await _scheduleRepository.CreateBookingSchedule(req2);
                
                if (res1.Successful && res2.Successful)
                {
                    await _scheduleRepository.UpdateBookingScheduleAvailability(new UpdateBookingScheduleRequest(req1.TimeSlot, req1.Office));
                    await _scheduleRepository.UpdateBookingScheduleAvailability(new UpdateBookingScheduleRequest(req2.TimeSlot, req2.Office));
                    return new CreateBookingScheduleResponse(true);
                }
                else
                {
                    return new CreateBookingScheduleResponse(false);
                }
            }
            
            else
            {
                var result = await _scheduleRepository.CreateBookingSchedule(request);
                var resp = new CreateBookingScheduleResponse();
                if (result.Successful)
                {
                    resp.Successful = true;
                }
                else
                {
                    resp.Successful = false;
                }
                await _scheduleRepository.UpdateBookingScheduleAvailability(new UpdateBookingScheduleRequest(request.TimeSlot, request.Office));
                return resp;
            }
        }

        public async Task<CancelBookingScheduleResponse> CancelBookingSchedule(CancelBookingScheduleRequest request)
        {
            //TODO: Increase availability when booking is cancelled
            if (request != null)
            {
                var resp = await _scheduleRepository.CancelBookingSchedule(request);
                if (resp.Response == true)
                {
                    var updateAvailability = new UpdateBookingScheduleRequest(request.TimeSlot, request.Office);
                    await _scheduleRepository.UpdateBookingScheduleAvailabilityAdd(updateAvailability);
                    return new CancelBookingScheduleResponse(true);
                }
                else
                {
                    return new CancelBookingScheduleResponse(false);
                }
            }
            else
            {
                throw new InvalidBookingException("Request is null or empty");
            }
        }

        public async Task<UpdateBookingScheduleResponse> UpdateBookingSchedule(UpdateBookingScheduleRequest request)
        {
            if (request != null)
            {
                var resp = await _scheduleRepository.UpdateBookingSchedule(request);
                return resp;
            }
            else
            {
                throw new InvalidBookingException("request is null or empty");

            }
        }

        public async Task<GetBookingScheduleResponse> ViewBookingSchedule(GetBookingScheduleRequest request)
        {
            if (request != null)
            {
                var resp = await _scheduleRepository.GetBookingSchedule(request);
                return resp;
            }
            else
            {
                throw new InvalidBookingException("request is null or empty");

            }
        }

        public async Task<GetAllBookingSchedulesResponse> ViewAllBookingSchedules(GetAllBookingSchedulesRequest request)
        {
            if (request != null)
            {
                var resp = await _scheduleRepository.GetAllBookingSchedules(request);
                return resp;
            }
            else
            {
                throw new InvalidBookingException("Request is null or empty");

            }
        }

        public async Task<CheckScheduleAvailabilityResponse> CheckAvailability(CheckScheduleAvailabilityRequest request)
        {
            if (request != null)
            {
                var bookingReqObj = new GetBookingScheduleRequest(request.TimeSlot, request.Office);
                var resp = await _scheduleRepository.GetBookingSchedule(bookingReqObj);
                if (resp.BookingSchedule.Availability > 0)
                {
                    return new CheckScheduleAvailabilityResponse(true);
                }
                else
                {
                    return new CheckScheduleAvailabilityResponse(false);
                }
            }
            else
            {
                throw new InvalidBookingException("Request is null or empty");
            }
        }

    }
}
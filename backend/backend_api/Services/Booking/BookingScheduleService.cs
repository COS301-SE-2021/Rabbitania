using System.Threading.Tasks;
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
            return resp;
        }

        public async Task<CancelBookingScheduleResponse> CancelBookingSchedule(CancelBookingScheduleRequest request)
        {
            if (request != null)
            {
                var resp = await _scheduleRepository.CancelBookingSchedule(request);
                if (resp.Response == true)
                {
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
                    //update booking request obj to update schedule availability
                    var updateBookingReq = new UpdateBookingScheduleRequest(request.TimeSlot, 
                        request.Office);
                    //Update the bookings availability
                    var UpdateResp = await _scheduleRepository.UpdateBookingScheduleAvailability(updateBookingReq);
                    
                    return new CheckScheduleAvailabilityResponse(UpdateResp.Success);
                    
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
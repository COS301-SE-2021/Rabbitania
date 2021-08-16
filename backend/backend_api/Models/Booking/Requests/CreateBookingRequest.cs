using System;
using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class CreateBookingRequest
    {
        private string _bookingDate;
        private string _timeSlot;
        private OfficeLocation _office;
        private int _userId;

        public CreateBookingRequest()
        {
            
        }

        public CreateBookingRequest(string bookingDate, string timeSlot, OfficeLocation office, int userId)
        {
            _bookingDate = bookingDate;
            _timeSlot = timeSlot;
            _office = office;
            _userId = userId;
        }

        public string BookingDate
        {
            get => _bookingDate;
            set => _bookingDate = value;
        }

        public string TimeSlot
        {
            get => _timeSlot;
            set => _timeSlot = value;
        }

        public OfficeLocation Office
        {
            get => _office;
            set => _office = value;
        }

        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }
    }
}
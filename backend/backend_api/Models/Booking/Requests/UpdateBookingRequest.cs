using System;
using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.Booking.Requests
{
    public class UpdateBookingRequest
    {
        private int _bookingID;
        private string _date;
        private float _duration;
        private string _timeSlot;
        private OfficeLocation _office;

        public UpdateBookingRequest()
        {
        }

        public UpdateBookingRequest(int bookingId, string date, float duration, string timeSlot, OfficeLocation office)
        {
            _bookingID = bookingId;
            this._date = date;
            this._duration = duration;
            this._timeSlot = timeSlot;
            this._office = office;
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

        public int BookingId
        {
            get => _bookingID;
            set => _bookingID = value;
        }

        public string Date
        {
            get => _date;
            set => _date = value;
        }

        public float Duration
        {
            get => _duration;
            set => _duration = value;
        }
    }
}
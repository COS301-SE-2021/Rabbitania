using System.Collections.Generic;

namespace backend_api.Models.Booking.Responses
{
    public class GetAllBookingSchedulesResponse
    {
        /// <summary>
        ///     Will return a response IEnumerable of type BookingSchedule
        ///     with a list of booking schedules
        /// </summary>
        private IEnumerable<BookingSchedule> _bookingSchedules;

        public GetAllBookingSchedulesResponse(IEnumerable<BookingSchedule> bookingSchedules)
        {
            _bookingSchedules = bookingSchedules;
        }

        public IEnumerable<BookingSchedule> BookingSchedules
        {
            get => _bookingSchedules;
            set => _bookingSchedules = value;
        }
    }
}
using System;
using backend_api.Models.User;

namespace backend_api.Models.Booking
{
    public interface IBookingSchedule
    {
        DateTime TimeSlot { get; set; }
        OfficeLocation Office { get; set; }
        int Availability { get; set; }
    }
}
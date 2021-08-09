using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Booking
{
    public interface IBookingScheduleContext
    {
        DbSet<Models.Booking.BookingSchedule> BookingSchedules { get; set; }
        Task<int> SaveChanges();
    }
}
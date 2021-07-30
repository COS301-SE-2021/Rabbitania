using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Booking
{
    public class BookingScheduleContext: DbContext, IBookingScheduleContext
    {
        public BookingScheduleContext()
        {
            
        }
        public BookingScheduleContext(DbContextOptions<BookingContext> options): base(options)
        {
            
        }
        public DbSet<Models.Booking.BookingSchedule> BookingSchedules { get; set; }
        public new async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
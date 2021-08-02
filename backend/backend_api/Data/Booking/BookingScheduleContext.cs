using System.Threading.Tasks;
using backend_api.Models.Booking;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Booking
{
    public class BookingScheduleContext: DbContext, IBookingScheduleContext
    {
        public BookingScheduleContext()
        {
            
        }
        public BookingScheduleContext(DbContextOptions<BookingScheduleContext> options) : base(options)
        {
            
        }
        public DbSet<Models.Booking.BookingSchedule> BookingSchedules { get; set; }
        public new async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<BookingSchedule>().HasKey(schedule => new
            {
                schedule.Office, schedule.TimeSlot
            });
        }
    }
}
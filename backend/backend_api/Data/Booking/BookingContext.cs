using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Booking
{
    public class BookingContext : DbContext, IBookingContext
    {
        public BookingContext(DbContextOptions<BookingContext> options) : base(options)
        {

        }

        public BookingContext()
        {
            
        }
        
        public DbSet<Models.Booking.Booking> Bookings { get; set; }

        public new async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
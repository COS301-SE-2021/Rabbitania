using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Booking
{
    public interface IBookingContext
    {
        DbSet<Models.Booking.Booking> Bookings { get; set; }

        Task<int> SaveChanges();
    }
}
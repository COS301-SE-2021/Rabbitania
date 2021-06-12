using System.Threading.Tasks;
using backend_api.Models;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data
{
    public class NotificationContext : DbContext, INotificationContext
    {
        
        public NotificationContext(DbContextOptions options) : base(options)
        {

        }

        public NotificationContext()
        {
            
        }
        
        public DbSet<Notification> Notifications { get; set; }

        public async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
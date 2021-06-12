using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Notification
{
    public class NotificationContext : DbContext, INotificationContext
    {
        
        public NotificationContext(DbContextOptions options) : base(options)
        {

        }

        public NotificationContext()
        {
            
        }
        
        public DbSet<Models.Notification.Notification> Notifications { get; set; }

        public async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
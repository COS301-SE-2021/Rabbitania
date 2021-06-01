using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;
using backend_api.Models.Notifications;

namespace backend_api.Models
{
    public interface IDatabaseContext
    {
        DbSet<User> users { get; set; }
        
        DbSet<Notification> notifications { get; set; }
        
        Task<int> SaveChanges();
    }
}
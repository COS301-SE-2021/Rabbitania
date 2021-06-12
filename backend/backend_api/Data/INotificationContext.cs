using backend_api.Models;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data
{
    public interface INotificationContext
    {
        DbSet<Notification> Notifications { get; set; }
    }
}
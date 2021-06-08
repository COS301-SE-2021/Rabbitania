using backend_api.Models.Notifications;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Notifications.Data
{
    public interface INotificationContext
    {
        DbSet<Notification> Notifications { get; set; }
    }
}
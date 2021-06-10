using backend_api.Models.Notifications;
using backend_api.Notifications.Models;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Notifications.Data
{
    public interface INotificationContext
    {
        DbSet<Notification> Notifications { get; set; }
    }
}
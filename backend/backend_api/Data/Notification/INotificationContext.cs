using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Notification
{
    public interface INotificationContext
    {
        DbSet<Models.Notification.Notification> Notifications { get; set; }
    }
}
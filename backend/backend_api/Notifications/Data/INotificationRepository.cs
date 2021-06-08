using System.Threading.Tasks;
using backend_api.Models.Notifications;

namespace backend_api.Notifications.Data
{
    public interface INotificationRepository : INotification
    {
        // RetrieveNotifications
        Task<Notification[]> RetrieveNotifications(int userID);
    }
}
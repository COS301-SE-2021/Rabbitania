using System.Threading.Tasks;

namespace backend_api.Models.Notifications.Repository
{
    public interface INotificationRepository : INotification
    {
        // RetrieveNotifications
        Task<Notification[]> RetrieveNotifications(int userID);
    }
}
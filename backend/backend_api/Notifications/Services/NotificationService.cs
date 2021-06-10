using System.Threading.Tasks;
using backend_api.Models.Notifications;
using backend_api.Notifications.Services;
using backend_api.Notifications.Data;
using backend_api.Notifications.Models;

namespace backend_api.Notifications.Services
{
    public class NotificationService : INotificationService
    {
        private readonly INotificationRepository _repository;

        public NotificationService(INotificationRepository _repository)
        {
            this._repository = _repository;
        }

        public async Task<Notification[]> RetrieveNotifications(int userID)
        {
            // returns null for now
            return null;
        }
    }
}
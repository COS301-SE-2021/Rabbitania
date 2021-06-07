using System.Threading.Tasks;
using backend_api.Models.Notifications.Repository;

namespace backend_api.Models.Notifications.Services
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
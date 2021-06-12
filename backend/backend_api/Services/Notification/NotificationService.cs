using backend_api.Data;
using backend_api.Data.Notification;
using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;

namespace backend_api.Services.Notification
{
    public class NotificationService : INotificationService
    {
        private readonly INotificationRepository _repository;

        public NotificationService(INotificationRepository repository)
        {
            this._repository = repository;
        }

        public RetrieveNotificationsResponse RetrieveNotifications(RetrieveNotificationRequest request)
        {
            // No validation for now to test services

            return _repository.RetrieveNotifications(request);
        }
    }
}
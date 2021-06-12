using backend_api.Data;
using backend_api.Models.Requests;
using backend_api.Models.Responses;

namespace backend_api.Services
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
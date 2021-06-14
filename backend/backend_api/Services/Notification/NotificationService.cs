using System;
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
            if (request.UserId is not (0 and >= 0))
            {
                throw new Exception("UserID is invalid");
            }
            if (request.UserId.Equals(null))
            {
                throw new Exception("UserID is null or empty");
            }
            
            return _repository.RetrieveNotifications(request);
        }

        public CreateNotificationResponse CreateNotification(CreateNotificationRequest request)
        {
            if (request.UserId is not (0 and >= 0))
            {
                throw new Exception("UserID is invalid");
            }
            if (request.NotificationType.Equals(null))
            {
                throw new Exception("Invalid Notification Type (Null or empty)");
            }

            return _repository.CreateNotification(request);
        }
    }
}
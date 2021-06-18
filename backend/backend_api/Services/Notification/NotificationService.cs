using System;
using System.Threading.Tasks;
using backend_api.Data;
using backend_api.Data.Notification;
using backend_api.Exceptions.Notifications;
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

        public async Task<RetrieveNotificationsResponse> RetrieveNotifications(RetrieveNotificationRequest request)
        {
            // No validation for now to test services
            if (request.UserId.Equals(null))
            {
                throw new InvalidNotificationRequestException("UserID is null or empty");
            }
            if (request.UserId <= 0)
            {
                throw new InvalidNotificationRequestException("UserID is invalid");
            }
            
            RetrieveNotificationsResponse response = new RetrieveNotificationsResponse(
                await _repository.RetrieveNotifications(request)
            );


            return response;
        }

        public async Task<CreateNotificationResponse> CreateNotification(CreateNotificationRequest request)
        {
            Console.WriteLine(request.UserId);
            if (request.UserId is 0 or < 0)
            {
                throw new InvalidNotificationRequestException("UserID is invalid");
            }
            if (string.IsNullOrEmpty(request.Payload))
            {
                throw new InvalidNotificationRequestException("Payload cannot be null or empty");
            }

            return await _repository.CreateNotification(request);
        }
    }
}
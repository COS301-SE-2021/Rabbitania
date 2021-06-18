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
            if (request == null)
            {
                throw new InvalidNotificationRequestException("Invalid RetrieveNotificationRequest object");
            }
            if (request.UserId is 0 or < 0)
            {
                throw new InvalidUserIdException("UserID is invalid");
            }
            
            var response = new RetrieveNotificationsResponse(
                await _repository.RetrieveNotifications(request)
            );


            return response;
        }

        public async Task<CreateNotificationResponse> CreateNotification(CreateNotificationRequest request)
        {
            if (request == null)
            {
                throw new InvalidNotificationRequestException("Invalid CreateNotificationRequest object");
            }
            if (request.UserId is 0 or < 0)
            {
                throw new InvalidUserIdException("UserID is invalid");
            }
            if (string.IsNullOrEmpty(request.Payload))
            {
                throw new InvalidPayloadException("Payload cannot be null or empty");
            }

            return await _repository.CreateNotification(request);
        }
    }
}
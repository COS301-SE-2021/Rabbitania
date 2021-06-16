using System;
using System.Threading.Tasks;
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

        public async Task<RetrieveNotificationsResponse> RetrieveNotifications(RetrieveNotificationRequest request)
        {
            // No validation for now to test services
            if (request.UserId.Equals(null))
            {
                throw new Exception("UserID is invalid");
            }
            if (request.UserId.Equals(null))
            {
                throw new Exception("UserID is null or empty");
            }
            
            RetrieveNotificationsResponse response = new RetrieveNotificationsResponse(
                "Notification successfully retrieved", await _repository.RetrieveNotifications(request)
            );


            return response;
        }

        public async Task<CreateNotificationResponse> CreateNotification(CreateNotificationRequest request)
        {
            Console.WriteLine(request.UserId);
            if (request.UserId.Equals(null) || request.UserId < 0)
            {
                throw new Exception("UserID is invalid");
            }
            if (request.Type.Equals(null))
            {
                throw new Exception("Invalid Notification Type (Null or empty)");
            }

            return await _repository.CreateNotification(request);
        }
    }
}
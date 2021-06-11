using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Notifications;
using backend_api.Notifications.Services;
using backend_api.Notifications.Data;
using backend_api.Notifications.Models;
using backend_api.Notifications.Models.Requests;
using backend_api.Notifications.Models.Responses;

namespace backend_api.Notifications.Services
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
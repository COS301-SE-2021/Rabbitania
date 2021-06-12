using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;

namespace backend_api.Services.Notification
{
    public interface INotificationService
    {
        RetrieveNotificationsResponse RetrieveNotifications(RetrieveNotificationRequest request);
    }
}
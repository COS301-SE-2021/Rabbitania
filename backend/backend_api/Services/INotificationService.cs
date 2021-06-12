using backend_api.Models.Requests;
using backend_api.Models.Responses;

namespace backend_api.Services
{
    public interface INotificationService
    {
        RetrieveNotificationsResponse RetrieveNotifications(RetrieveNotificationRequest request);
    }
}
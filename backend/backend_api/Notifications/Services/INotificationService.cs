using System.Threading.Tasks;
using backend_api.Notifications.Models.Requests;
using backend_api.Notifications.Models.Responses;

namespace backend_api.Notifications.Services
{
    public interface INotificationService
    {
        RetrieveNotificationsResponse RetrieveNotifications(RetrieveNotificationRequest request);
    }
}
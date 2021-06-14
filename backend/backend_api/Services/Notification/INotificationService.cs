using System.Threading.Tasks;
using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;

namespace backend_api.Services.Notification
{
    public interface INotificationService
    {
        /// <summary>
        ///     Validates whether or not the request is valid
        ///     returns thereafter a List of notifications of
        ///     the notifications.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>List of Notifications for user.</returns>
        RetrieveNotificationsResponse RetrieveNotifications(RetrieveNotificationRequest request);

        /// <summary>
        ///     Validates whether or not the request is valid
        ///     if valid creates a new notification for the user.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Response success message</returns>
        Task<CreateNotificationResponse> CreateNotification(CreateNotificationRequest request);
    }
}
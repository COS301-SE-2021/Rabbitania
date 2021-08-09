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
        Task<RetrieveNotificationsResponse> RetrieveNotifications(RetrieveNotificationRequest request);

        /// <summary>
        ///     Validates whether or not the request is valid
        ///     if valid creates a new notification for the user.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Response success message</returns>
        Task<CreateNotificationResponse> CreateNotification(CreateNotificationRequest request);
        
        
        /// <summary>
        /// Checks whether the email request is valid ( i.e valid email address and valid payload and subject),
        /// then sends the appropriate email to the user.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Response Http status code </returns>
        Task<SendEmailNotificationResponse> SendEmailNotification(SendEmailNotificationRequest request);
    }
}
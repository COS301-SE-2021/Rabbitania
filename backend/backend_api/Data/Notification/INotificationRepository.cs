using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;

namespace backend_api.Data.Notification
{
    public interface INotificationRepository
    {
        /// <summary>
        ///     Fetches all of the notifications of a particular user from the DBContext.
        /// </summary>
        /// <param name="request"></param>
        /// <returns> A list of notifications </returns>
        RetrieveNotificationsResponse RetrieveNotifications(RetrieveNotificationRequest request);
        
        /// <summary>
        ///     Creates a new notification for a user
        /// </summary>
        /// <param name="request"></param>
        /// <returns> Created Notification Response </returns>
        CreateNotificationResponse CreateNotification(CreateNotificationRequest request);
    }

}
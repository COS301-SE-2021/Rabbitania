using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Notifications;
using backend_api.Notifications.Models;
using backend_api.Notifications.Models.Requests;
using backend_api.Notifications.Models.Responses;

namespace backend_api.Notifications.Data
{
    public interface INotificationRepository
    {
        /// <summary>
        ///     Fetches all of the notifications of a particular user from the DBContext.
        /// </summary>
        /// <param name="request"></param>
        /// <returns> A list of notifications </returns>
        RetrieveNotificationsResponse RetrieveNotifications(RetrieveNotificationRequest request);
    }

}
using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Notifications;

namespace backend_api.Notifications.Data
{
    public interface INotificationRepository
    {
        /// <summary>
        ///     Fetches all of the notifications of a particular user from the DBContext.
        /// </summary>
        /// <param name="userID"></param>
        /// <returns> A list of notifications </returns>
        Task<List<Notification>> RetrieveNotifications(int userID);
    }
}
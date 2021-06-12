using backend_api.Models.Requests;
using backend_api.Models.Responses;

namespace backend_api.Data
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
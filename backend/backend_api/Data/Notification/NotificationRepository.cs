using System.Linq;
using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;

namespace backend_api.Data.Notification
{
    public class NotificationRepository : INotificationRepository
    {
        private readonly INotificationContext _context;
        
        public NotificationRepository(INotificationContext context)
        {
            this._context = context;
        }
        
     
        /// <inheritdoc />
        public RetrieveNotificationsResponse RetrieveNotifications(RetrieveNotificationRequest request)
        {
            IQueryable<Models.Notification.Notification> retrieveUserNotifications = _context.Notifications.Where(notification => notification.UserId == request.UserId);

            RetrieveNotificationsResponse response = new RetrieveNotificationsResponse(
                "Notification successfully retrieved", retrieveUserNotifications
            );
            
            return response;
        }
    }
}
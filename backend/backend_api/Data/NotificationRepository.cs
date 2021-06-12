using System.Linq;
using backend_api.Models;
using backend_api.Models.Requests;
using backend_api.Models.Responses;

namespace backend_api.Data
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
            IQueryable<Notification> retrieveUserNotifications = _context.Notifications.Where(notification => notification.UserId == request.UserId);

            RetrieveNotificationsResponse response = new RetrieveNotificationsResponse(
                "Notification successfully retrieved", retrieveUserNotifications
            );
            
            return response;
        }
    }
}
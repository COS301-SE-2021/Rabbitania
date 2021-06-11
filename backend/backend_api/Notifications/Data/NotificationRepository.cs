using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Models.Notifications;
using backend_api.Notifications.Models;
using backend_api.Notifications.Models.Requests;
using backend_api.Notifications.Models.Responses;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Notifications.Data
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
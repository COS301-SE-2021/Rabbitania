using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Models.Notifications;
using backend_api.Notifications.Models;
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
        public async Task<List<Notification>> RetrieveNotifications(int userID)
        {
           IQueryable<Notification> retrieveUserNotifications = _context.Notifications.Where(notification => notification.UserId == userID);
           return await retrieveUserNotifications.ToListAsync();
        }
    }
}
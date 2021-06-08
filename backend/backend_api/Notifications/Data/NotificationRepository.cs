using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Models.Notifications;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Notifications.Data
{
    public class NotificationRepository
    {
        private readonly INotificationContext _context;
        
        public NotificationRepository(INotificationContext context)
        {
            this._context = context;
        }
        
        /// <summary>
        ///     Fetches all of the notifications of a particular user from the DBContext.
        /// </summary>
        /// <param name="userID"></param>
        /// <returns> A list of notifications </returns>
        public async Task<Notification[]> RetrieveNotifications(int userID)
        {
           // IQueryable<Notification> retrieveUserNotifications = _context.notifications.Where(notification => notification.UserID == userID);
           // return await retrieveUserNotifications.ToArrayAsync();
           return null;
        }
    }
}
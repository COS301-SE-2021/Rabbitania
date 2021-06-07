using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Models.Notifications.Repository
{
    public class NotificationRepository
    {
        private readonly IDatabaseContext _context;
        
        public NotificationRepository(IDatabaseContext _context)
        {
            this._context = _context;
        }
        
        /// <summary>
        ///     Fetches all of the notifications of a particular user.
        /// </summary>
        /// <param name="userID"></param>
        /// <returns> A list of notifications </returns>
        public async Task<Notification[]> RetrieveNotifications(int userID)
        {
            IQueryable<Notification> retrieveUserNotifications = _context.notifications.Where(notification => notification.UserID == userID);
            return await retrieveUserNotifications.ToArrayAsync();
        }
    }
}
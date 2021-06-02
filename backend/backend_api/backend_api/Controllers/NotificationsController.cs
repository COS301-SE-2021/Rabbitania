using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using backend_api.Models;
using backend_api.Models.Notifications;

namespace backend_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NotificationsController : ControllerBase
    {
        private readonly DatabaseContext _context;

        public NotificationsController(DatabaseContext context)
        {
            _context = context;
        }
        
        /// <summary>
        /// This function returns all of the notifications within the table
        /// </summary>
        /// <returns>A list of all of the notifications in the database</returns>
        [HttpGet("/retrieveAllNotifications")]
        public async Task<ActionResult<IEnumerable<Notification>>> retrieveAllNotifications()
        {
            return await _context.notifications.ToListAsync();
        }

        /// <summary>
        /// Fetches the user in which the passed in ID correlates to. Then retreives all
        /// of that users notifications.
        /// </summary>
        /// <param name="userID"></param>
        /// <returns>list of all of a users notifications</returns>
        [HttpGet("/retrieveAllUsersNotification/{userID}")]
        public async Task<List<Notification>> retrieveAllUsersNotification(int userID)
        {
            // Linq/Lamba query to find all notifications where the FK UserID == userid given
            try
            {
                var selectedUserNotifications = await _context.notifications
                    .Where(n => n.UserID == userID).ToListAsync();
                
                return selectedUserNotifications;
            }
            catch (WebException error)
            {
                return null;
            }
        }

        /// <summary>
        /// Create notification, this is where the notification will be created either of type:
        ///  - Push notification
        ///  - Email notification
        /// </summary>
        /// <param name="notification"></param>
        /// <returns></returns>
        [HttpPost]
        public async Task<ActionResult<Notification>> PostNotification(Notification notification)
        {
            _context.notifications.Add(notification);
            await _context.SaveChangesAsync();

            return CreatedAtAction("retrieveAllNotifications", new { id = notification.notificationID }, notification);
        }

        // DELETE: api/Notifications/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteNotification(int id)
        {
            var notification = await _context.notifications.FindAsync(id);
            if (notification == null)
            {
                return NotFound();
            }

            _context.notifications.Remove(notification);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool NotificationExists(int id)
        {
            return _context.notifications.Any(e => e.notificationID == id);
        }
    }
}

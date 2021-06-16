using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;
using Microsoft.EntityFrameworkCore;

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
        public async Task<List<Models.Notification.Notification>> RetrieveNotifications(RetrieveNotificationRequest request)
        {
            IQueryable<Models.Notification.Notification> retrieveUserNotifications = _context.Notifications.Where(notification => notification.UserID == request.UserId);

            return await retrieveUserNotifications.ToListAsync();
        }

        /// <inheritdoc />
        public async Task<CreateNotificationResponse> CreateNotification(CreateNotificationRequest request)
        {
            var newNot = new Models.Notification.Notification();
            newNot.NotificationContent = request.NotificationContext;
            newNot.NotificationType = request.NotificationType;
            newNot.DateCreated = request.DateCreated;
            newNot.UserID = request.UserId;
            
            _context.Notifications.Add(newNot);
            await _context.SaveChanges();

            CreateNotificationResponse response = new CreateNotificationResponse("Successfully created user");

            return response;
        }
    }
}
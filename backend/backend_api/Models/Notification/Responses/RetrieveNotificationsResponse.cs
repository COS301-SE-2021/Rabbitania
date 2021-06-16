using System.Collections.Generic;

namespace backend_api.Models.Notification.Responses
{
    public class RetrieveNotificationsResponse
    {
        private IEnumerable<Notification> _notifications;
        
        public RetrieveNotificationsResponse(IEnumerable<Notification> notifications)
        {
            this._notifications = notifications;
        }

        public IEnumerable<Notification> Notifications
        {
            get => _notifications;
            set => _notifications = value;
        }
    }
}
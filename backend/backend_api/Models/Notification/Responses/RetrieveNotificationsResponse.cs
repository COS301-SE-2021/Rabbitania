using System.Collections.Generic;

namespace backend_api.Models.Notification.Responses
{
    public class RetrieveNotificationsResponse
    {
        private string _message;
        private IEnumerable<Notification> _notifications;
        
        public RetrieveNotificationsResponse(string message, IEnumerable<Notification> notifications)
        {
            this._message = message;
            this._notifications = notifications;
        }

        public string Message
        {
            get => _message;
            set => _message = value;
        }

        public IEnumerable<Notification> Notifications
        {
            get => _notifications;
            set => _notifications = value;
        }
    }
}
using System.Collections.Generic;

namespace backend_api.Notifications.Models.Responses
{
    public class RetrieveNotificationsResponse
    {
        private string _message;
        private List<Notification> _notifications;

        public RetrieveNotificationsResponse(string message, List<Notification> notifications)
        {
            this._message = message;
            this._notifications = notifications;
        }
        
        public string Message
        {
            get => _message;
            set => _message = value;
        }

        public List<Notification> Notifications
        {
            get => _notifications;
            set => _notifications = value;
        }
    }
}
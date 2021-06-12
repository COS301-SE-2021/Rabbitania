using System.Collections.Generic;

namespace backend_api.Models.Notification.Responses
{
    public class RetrieveNotificationsResponse
    {
        public RetrieveNotificationsResponse(string message, IEnumerable<Notification> notifications)
        {
            this.Message = message;
            this.Notifications = notifications;
        }
        
        public string Message { get; set; }
        public IEnumerable<Notification> Notifications { get; set; }
    }
}
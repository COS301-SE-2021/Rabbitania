using System.Collections.Generic;
using System.Text.Json.Serialization;
using Newtonsoft.Json;

namespace backend_api.Notifications.Models.Responses
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
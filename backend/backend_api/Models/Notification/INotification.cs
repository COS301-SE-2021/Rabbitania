using System;
using backend_api.Models.Enumerations;

namespace backend_api.Models.Notification
{
    public interface INotification
    {
        int NotificationId { get; set; }
        string Payload { get; set; }
        NotificationTypeEnum Type { get; set; }
        DateTime CreatedDate { get; set; }
        int UserId { get; set; }
    }
}
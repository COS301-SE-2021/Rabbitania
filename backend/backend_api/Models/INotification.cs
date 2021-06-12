using System;

namespace backend_api.Models
{
    public interface INotification
    {
        int NotificationId { get; set; }
        string NotificationContent { get; set; }
        NotificationTypeEnum NotificationType { get; set; }
        DateTime DateCreated { get; set; }
        int UserId { get; set; }
    }
}
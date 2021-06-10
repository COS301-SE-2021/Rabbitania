using System;
using backend_api.Models.Notifications;

namespace backend_api.Notifications.Models
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
using System;

namespace backend_api.Models.Notification
{
    public interface INotification
    {
        int NotificationId { get; set; }
        string NotificationPayload { get; set; }
        NotificationTypeEnum NotificationType { get; set; }
        DateTime DateCreated { get; set; }
        int UserID { get; set; }
    }
}
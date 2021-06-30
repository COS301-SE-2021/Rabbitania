using System;

namespace backend_api.Models.Notification
{
    public interface INotification
    {
        int NotificationId { get; set; }
        string NotificationPayload { get; set; }
        NotificationTypeEnum NotificationType { get; set; }
        DateTime CreatedDate { get; set; }
        int UserID { get; set; }
    }
}
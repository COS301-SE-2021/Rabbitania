using System;

namespace backend_api.Models.Notification.Requests
{
    public class CreateNotificationRequest
    {
        private int _notificationId;
        private string _notificationContext;
        private int _notificationType;
        private DateTime _dateCreated;
        private int _userId;

        public CreateNotificationRequest(int notificationId, string notificationContext, int notificationType, DateTime dateCreated, int userId)
        {
            this._notificationId = notificationId;
            this._notificationContext = notificationContext;
            this._notificationType = notificationType;
            this._dateCreated = dateCreated;
            this._userId = userId;
        }

        public int NotificationId
        {
            get => _notificationId;
            set => _notificationId = value;
        }

        public string NotificationContext
        {
            get => _notificationContext;
            set => _notificationContext = value;
        }

        public int NotificationType
        {
            get => _notificationType;
            set => _notificationType = value;
        }

        public DateTime DateCreated
        {
            get => _dateCreated;
            set => _dateCreated = value;
        }

        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }
    }
}
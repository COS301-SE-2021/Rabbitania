using System;
using backend_api.Models.Enumerations;

namespace backend_api.Models.Notification.Requests
{
    public class CreateNotificationRequest
    {
        private string _payload;
        private NotificationTypeEnum _type;
        private DateTime _dateCreated;
        private int _userId;

        public CreateNotificationRequest()
        {
            
        }
        public CreateNotificationRequest(string payload, NotificationTypeEnum type, DateTime dateCreated, int userId)
        {
            this._payload = payload;
            this._type = type;
            this._dateCreated = dateCreated;
            this._userId = userId;
        }

        public string Payload
        {
            get => _payload;
            set => _payload = value;
        }

        public NotificationTypeEnum Type
        {
            get => _type;
            set => _type = value;
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
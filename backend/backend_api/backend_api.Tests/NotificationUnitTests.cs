using System;
using backend_api.Models;
using backend_api.Models.Notifications;
using Xunit;
namespace backend_api.Tests
{
    public class NotificationUnitTests
    {
        private readonly Notification _sutNotification;
        private readonly NotificationTypeEnum _sutNotificationTypeEnum;
        private readonly DateTime _dateTime;

        public NotificationUnitTests()
        {
            this._sutNotification = new Notification();
            this._sutNotificationTypeEnum = new NotificationTypeEnum();
            this._sutNotificationTypeEnum = NotificationTypeEnum.Email;
            this._dateTime = new DateTime();

        }

        [Fact]
        public void CreateNewNotification()
        {
            SetNotificationId();
            SetNotificationContent();
            SetNotificationType();
            SetNotificationDateCreated();
        }
        [Fact]
        public void SetNotificationId()
        {
            this._sutNotification.notificationID = 100;
            Assert.Equal(100, this._sutNotification.notificationID);
        }
        
        [Fact]
        public void SetNotificationContent()
        {
            this._sutNotification.notificationContent = "Notification unitTest for Setting content ";
            Assert.Equal("Notification unitTest for Setting content ", this._sutNotification.notificationContent);
        }
        
        [Fact]
        public void SetNotificationType()
        {
            this._sutNotification.notificationType = _sutNotificationTypeEnum;
            Assert.Equal( this._sutNotificationTypeEnum, this._sutNotification.notificationType);
            
        }
        
        [Fact]
        public void SetNotificationDateCreated()
        {
            this._sutNotification.dateCreated = _dateTime;
            Assert.Equal(_dateTime, this._sutNotification.dateCreated);
        }
        
        
        
        
        [Fact]
        public void GetNotificationId()
        {
    
        }
        [Fact]
        public void NotificationContent()
        {
            
        }
        [Fact]
        public void NotificationType()
        {
            
        }
        [Fact]
        public void DateCreated()
        {
        }
        
    }
    
   
}
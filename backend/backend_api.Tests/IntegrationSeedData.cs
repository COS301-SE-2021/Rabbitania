using System;
using backend_api.Data.Notification;
using backend_api.Models.Enumerations;
using backend_api.Models.Notification;

namespace backend_api.Tests
{
    public class IntegrationSeedData
    {
        public static void MockData(NotificationContext nContext)
        {
            nContext.Notifications.Add(new Models.Notification.Notification("Hello from tests", NotificationTypeEnum.Email, DateTime.Now, 1));
            nContext.Notifications.Add(new Models.Notification.Notification("Hello from tests again", NotificationTypeEnum.Email, DateTime.Now, 1));
            nContext.SaveChanges();
        }
    }
}
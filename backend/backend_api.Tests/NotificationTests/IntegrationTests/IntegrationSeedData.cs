using System;
using backend_api.Data.Notification;
using backend_api.Models.Notification;

namespace backend_api.Tests.NotificationTests.IntegrationTests
{
    public class IntegrationSeedData
    {
        public static void MockData(NotificationContext nContext)
        {
            nContext.Notifications.Add(new Notification("Hello from tests", NotificationTypeEnum.Email, DateTime.Now, 2));
            nContext.Notifications.Add(new Notification("Hello from tests again", NotificationTypeEnum.Email, DateTime.Now, 2));
            nContext.SaveChanges();
        }
    }
}
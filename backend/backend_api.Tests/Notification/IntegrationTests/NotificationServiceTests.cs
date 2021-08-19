using System;
using System.Net;
using backend_api.Data.Notification;
using backend_api.Data.User;
using backend_api.Models.Enumerations;
using backend_api.Models.Notification.Requests;
using backend_api.Models.User;
using backend_api.Services.Auth;
using backend_api.Services.Notification;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Xunit;

namespace backend_api.Tests.Notification.IntegrationTests
{
    public class NotificationServiceTests
    {
        private readonly Models.Notification.Notification _notification;
        private INotificationContext _notificationContext;
        private readonly NotificationRepository _notificationRepository;
        private readonly NotificationService _notificationService;
        
        public NotificationServiceTests()
        {
            var serviceProvider = new ServiceCollection().AddEntityFrameworkNpgsql().BuildServiceProvider();
            var builder = new DbContextOptionsBuilder<NotificationContext>();
            
            builder.UseNpgsql("Server=ec2-34-247-118-233.eu-west-1.compute.amazonaws.com:5432;Port=5432;Database=d924vmqoqh9aba;Username=jpbxojhfderusg;Password=a231e88acb43722af04a63aeab3cb65aeb770459b6e201e9498a7d7543a60d5c;SslMode=Require;Trust Server Certificate=true;")
                .UseInternalServiceProvider(serviceProvider);

            _notificationContext = new NotificationContext(builder.Options);
        }

        [Fact]
        public async void CreateNotification_Valid()
        {
            //Arrange
            var req = new CreateNotificationRequest("Hello", NotificationTypeEnum.Email, DateTime.Now, 1);
            //Act
            var resp = await _notificationService.CreateNotification(req);
            //Assert
            Assert.Equal(HttpStatusCode.Created, resp.HttpStatusCode);
        }
    }
}
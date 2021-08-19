using System;
using System.Net;
using backend_api.Data.Notification;
using backend_api.Data.User;
using backend_api.Exceptions.Notifications;
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
        private INotificationContext _notificationContext;
        private readonly INotificationRepository _notificationRepository;
        private readonly INotificationService _notificationService;
        
        public NotificationServiceTests()
        {
            var serviceProvider = new ServiceCollection().AddEntityFrameworkNpgsql().BuildServiceProvider();
            var builder = new DbContextOptionsBuilder<NotificationContext>();
            
            builder.UseNpgsql("Server=ec2-34-247-118-233.eu-west-1.compute.amazonaws.com:5432;Port=5432;Database=d924vmqoqh9aba;Username=jpbxojhfderusg;Password=a231e88acb43722af04a63aeab3cb65aeb770459b6e201e9498a7d7543a60d5c;SslMode=Require;Trust Server Certificate=true;")
                .UseInternalServiceProvider(serviceProvider);

            _notificationContext = new NotificationContext(builder.Options);
            
            _notificationRepository = new NotificationRepository(_notificationContext);
            _notificationService = new NotificationService(_notificationRepository);
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

        [Fact]
        public async void CreateNotification_InvalidNotification()
        {
            //Arrange
            var req = new CreateNotificationRequest();
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserIdException>(async () => await _notificationService.CreateNotification(req));
        }

        [Fact]
        public async void CreateNotification_InvalidPayload()
        {
            //Arrange
            var req = new CreateNotificationRequest("",NotificationTypeEnum.Email, DateTime.Now, 1);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidPayloadException>(async () => await _notificationService.CreateNotification(req));
        }

        [Fact]
        public async void RetrieveNotification_ValidNotification()
        {
            //Arrange
            var req = new RetrieveNotificationRequest(1);
            //Act
            var resp = await _notificationService.RetrieveNotifications(req);
            //Assert
            Assert.NotNull(resp);
        }
        [Fact]
        public async void RetrieveNotification_NullUser()
        {
            //Arrange
            var req = new RetrieveNotificationRequest();
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserIdException>(async () => await _notificationService.RetrieveNotifications(req));
        }
        
        [Fact]
        public async void RetrieveNotification_InvalidUser()
        {
            //Arrange
            var req = new RetrieveNotificationRequest(-1000);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserIdException>(async () => await _notificationService.RetrieveNotifications(req));
        }

        [Fact]
        public async void RetrieveNotification_NullRequest()
        {
            //Arrange
            RetrieveNotificationRequest req = null;
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNotificationRequestException>(async () => await _notificationService.RetrieveNotifications(req));
        }
        [Fact]
        public async void SendEmailNotification_NullEmailRequest()
        {
            //Arrange
            var req = new SendEmailNotificationRequest("test", "test", null);
            //Act
            //Assert
            await Assert.ThrowsAsync<EmailFailedToSendException>(async () => await _notificationService.SendEmailNotification(req));
        }
        [Fact]
        public async void SendEmailNotification_Null()
        {
            //Arrange
            SendEmailNotificationRequest req = null;
            //Act
            //Assert
            await Assert.ThrowsAsync<NullReferenceException>(async () => await _notificationService.SendEmailNotification(req));
        }
    }
}
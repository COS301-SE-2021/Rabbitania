using System;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.Notification;
using backend_api.Models.Notification;
using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;
using backend_api.Services.Notification;
using Moq;
using Xunit;

namespace backend_api.Tests.NotificationTests.UnitTests
{
    public class NotificationServiceTests
    {
        private readonly NotificationService _sut;
        private readonly Mock<INotificationRepository> _notificationRepoMock = new Mock<INotificationRepository>();
        private readonly DateTime _mockedDate;
        
        public NotificationServiceTests()
        {
            // Mocks the implementation of Notification repository
            _sut = new NotificationService(_notificationRepoMock.Object);
            
            _mockedDate = new DateTime();
        }
        
        [Fact]
        public async Task CreateNotification_ShouldReturnCreatedStatusCodeAsync()
        {
            // Arrange
            var mockReq = new CreateNotificationRequest(
                    "Notification Test",
                    NotificationTypeEnum.Email,
                    this._mockedDate,
                    1
                );
            var mockRes = new CreateNotificationResponse(HttpStatusCode.Created);
            
            _notificationRepoMock.Setup(n => n.CreateNotification(mockReq)).ReturnsAsync(mockRes);
            
            // Act
            var createdNotification = await _sut.CreateNotification(mockReq);
            
            // Assert
            Assert.Equal(mockRes, createdNotification);
        } 
        
        [Fact]
        public async Task CreateNotification_ShouldReturnFailAsync()
        {
            // Arrange
            var mockReq = new CreateNotificationRequest(
                "Notification Test",
                NotificationTypeEnum.Email,
                this._mockedDate,
                1
            );
            var mockRes = new CreateNotificationResponse(HttpStatusCode.Created);
            
            _notificationRepoMock.Setup(n => n.CreateNotification(mockReq)).ReturnsAsync(mockRes);
            
            // Act
            var createdNotification = await _sut.CreateNotification(mockReq);
            
            // Assert
            Assert.Equal(mockRes, createdNotification);
        } 
    }
}
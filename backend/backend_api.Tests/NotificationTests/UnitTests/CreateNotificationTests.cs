using System;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.Notification;
using backend_api.Exceptions.Auth;
using backend_api.Exceptions.Notifications;
using backend_api.Models.Notification;
using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;
using backend_api.Services.Notification;
using Moq;
using Xunit;

namespace backend_api.Tests.NotificationTests.UnitTests
{
    public class CreateNotificationTests
    {
        private readonly NotificationService _sut;
        private readonly Mock<INotificationRepository> _notificationRepoMock = new Mock<INotificationRepository>();
        private readonly DateTime _mockedDate;
        
        public CreateNotificationTests()
        {
            // Mocks the implementation of Notification repository
            _sut = new NotificationService(_notificationRepoMock.Object);
            
            _mockedDate = new DateTime();
        }
        
        [Fact(DisplayName = "When a new notification is created, it should return HttpStatusCode 201")]
        public async Task CreateNotification_ShouldReturnCreatedStatusCodeAsync()
        {
            // Arrange
            var requestDto = new CreateNotificationRequest(
                "Notification Test",
                    NotificationTypeEnum.Email,
                    this._mockedDate,
                    1
                );
            var responseDto = new CreateNotificationResponse(HttpStatusCode.Created);
            
            _notificationRepoMock.Setup(n => n.CreateNotification(requestDto)).ReturnsAsync(responseDto);
            
            // Act
            var createdNotification = await _sut.CreateNotification(requestDto);
            
            // Assert
            Assert.Equal(responseDto, createdNotification);
        }
        
        [Fact(DisplayName = "When a request object is null, the notification shouldn't be created and throw a InvalidNotificationRequestException")]
        public async Task CreateNotification_ShouldNotReturnCreatedAndIsNullAsync()
        {
            // Arrange & Act
            var exception = await Assert.ThrowsAsync<InvalidNotificationRequestException>(() => _sut.CreateNotification(null));
            
            // Assert
            Assert.Equal("Invalid CreateNotificationRequest object", exception.Message);
        }
        
        
        [Fact(DisplayName = "When payload is empty, CreateNotification should throw an InvalidPayloadException")]
        public async Task CreateNotification_ShouldThrowExceptionWhenPayloadIsEmptyAsync()
        {
            // Arrange
            var requestDto = new CreateNotificationRequest(
                "",
                NotificationTypeEnum.Email,
                this._mockedDate,
                1
            );

            // Act
            var exception = await Assert.ThrowsAsync<InvalidPayloadException>(() => _sut.CreateNotification(requestDto));
            
            // Assert
            Assert.Equal("Payload cannot be null or empty", exception.Message);
        } 
        
        [Fact(DisplayName = "When payload is null, CreateNotification should throw an InvalidPayloadException")]
        public async Task CreateNotification_ShouldThrowExceptionWhenPayloadIsNullAsync()
        {
            // Arrange
            var requestDto = new CreateNotificationRequest(
                null,
                NotificationTypeEnum.Email,
                this._mockedDate,
                1
            );

            // Act
            var exception = await Assert.ThrowsAsync<InvalidPayloadException>(() => _sut.CreateNotification(requestDto));
            
            // Assert
            Assert.Equal("Payload cannot be null or empty", exception.Message);
        }
        
        [Fact(DisplayName = "When a UserId is zero, CreateNotification should throw an InvalidUserIdException")]
        public async Task CreateNotification_ShouldThrowExceptionWhenUserIdIsZeroAsync()
        {
            // Arrange
            var requestDto = new CreateNotificationRequest(
                "Notification Test",
                NotificationTypeEnum.Email,
                this._mockedDate,
                0
                );

            // Act
            var exception = await Assert.ThrowsAsync<InvalidUserIdException>(() => _sut.CreateNotification(requestDto));
            
            // Assert
            Assert.Equal("UserID is invalid", exception.Message);
        }
        
        [Fact(DisplayName = "When UserId is negative, CreateNotification should throw an InvalidUserIdException")]
        public async Task CreateNotification_ShouldThrowExceptionWhenUserIdIsLessThanZeroAsync()
        {
            // Arrange
            var requestDto = new CreateNotificationRequest(
                "Notification Test",
                NotificationTypeEnum.Email,
                this._mockedDate,
                -1
            );

            // Act
            var exception = await Assert.ThrowsAsync<InvalidUserIdException>(() => _sut.CreateNotification(requestDto));
            
            // Assert
            Assert.Equal("UserID is invalid", exception.Message);
        } 
    }
}
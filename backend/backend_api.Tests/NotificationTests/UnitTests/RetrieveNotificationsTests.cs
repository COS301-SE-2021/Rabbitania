using System.Threading.Tasks;
using backend_api.Data.Notification;
using backend_api.Exceptions.Notifications;
using backend_api.Models.Notification.Requests;
using backend_api.Services.Notification;
using Moq;
using Xunit;

namespace backend_api.Tests.NotificationTests.UnitTests
{
    public class RetrieveNotificationsTests
    {
        private readonly NotificationService _sut;
        private readonly Mock<INotificationRepository> _notificationRepoMock = new Mock<INotificationRepository>();

        public RetrieveNotificationsTests()
        {
            _sut = new NotificationService(_notificationRepoMock.Object);
        }
        
        [Fact(DisplayName = "When the RetrieveNotificationRequest is null is should throw an exception")]
        public async Task RetrieveNotifications_ShouldThrowAnInvalidNotificationRequestExceptionWhenRequestIsNullAsync()
        {
            // Arrange & Act
            var exception = await Assert.ThrowsAsync<InvalidNotificationRequestException>(() => _sut.RetrieveNotifications(null));
            
            // Assert
            Assert.Equal("Invalid RetrieveNotificationRequest object", exception.Message);
        }
        
        // Should return a list of objects...
        
        [Fact(DisplayName = "When a userId is zero the system should throw an InvalidUserIdException")]
        public async Task RetrieveNotifications_ShouldThrowAnInvalidUserIdExceptionWhenUserIdIsZeroAsync()
        {
            // Arrange
            var requestDto = new RetrieveNotificationRequest(
                0
            );

            // Act
            var exception = await Assert.ThrowsAsync<InvalidUserIdException>(() => _sut.RetrieveNotifications(requestDto));
            
            // Assert
            Assert.Equal("UserID is invalid", exception.Message);
        }
        
        [Fact(DisplayName = "When a userId is negative the system should throw an InvalidUserIdException")]
        public async Task RetrieveNotifications_ShouldThrowAnInvalidUserIdExceptionWhenUserIdIsNegativeAsync()
        {
            // Arrange
            var requestDto = new RetrieveNotificationRequest(
                -1
            );

            // Act
            var exception = await Assert.ThrowsAsync<InvalidUserIdException>(() => _sut.RetrieveNotifications(requestDto));
            
            // Assert
            Assert.Equal("UserID is invalid", exception.Message);
        } 
        
        
    }
}
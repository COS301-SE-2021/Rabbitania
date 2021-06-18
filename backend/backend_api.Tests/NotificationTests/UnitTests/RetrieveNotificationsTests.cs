using System.Threading.Tasks;
using backend_api.Data.Notification;
using backend_api.Exceptions.Notifications;
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
        public async Task RetrieveNotifications_ShouldThrowAnInvalidNotificationRequestExceptionAsync()
        {
            // Arrange & Act
            var exception = await Assert.ThrowsAsync<InvalidNotificationRequestException>(() => _sut.RetrieveNotifications(null));
            
            // Assert
            Assert.Equal("Invalid RetrieveNotificationRequest object", exception.Message);
        } 
    }
}
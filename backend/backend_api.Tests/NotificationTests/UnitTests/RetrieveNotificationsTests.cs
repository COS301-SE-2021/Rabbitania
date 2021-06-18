using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Data.Notification;
using backend_api.Exceptions.Notifications;
using backend_api.Models.Notification;
using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;
using backend_api.Services.Notification;
using Microsoft.EntityFrameworkCore;
using Moq;
using Xunit;
using Xunit.Abstractions;

namespace backend_api.Tests.NotificationTests.UnitTests
{
    public class RetrieveNotificationsTests
    {
        private readonly ITestOutputHelper _testOutputHelper;
        private readonly NotificationService _sut;
        private readonly Mock<INotificationRepository> _notificationRepoMock = new Mock<INotificationRepository>();
        private readonly DateTime _mockedDate;
        private readonly List<Notification> _mockedListDto;
        
        public RetrieveNotificationsTests(ITestOutputHelper testOutputHelper)
        {
            _testOutputHelper = testOutputHelper;
            _sut = new NotificationService(_notificationRepoMock.Object);
            
            _mockedDate = new DateTime();
            
            _mockedListDto = new List<Notification>(){
                new Notification {
                    NotificationPayload = "Well done to the Rabbitanaia Team!", 
                    NotificationType = NotificationTypeEnum.Email,
                    CreatedDate = _mockedDate,
                    UserID = 1
                },
                new Notification {
                    NotificationPayload = "Meeting at 12:30 with Design Team", 
                    NotificationType = NotificationTypeEnum.Push,
                    CreatedDate = _mockedDate,
                    UserID = 1
                },
                new Notification {
                    NotificationPayload = "Don't forget to do you tests!", 
                    NotificationType = NotificationTypeEnum.Email,
                    CreatedDate = _mockedDate,
                    UserID = 1
                }
            };
        }
        
        
        [Fact(DisplayName = "When the RetrieveNotificationRequest is null is should throw an exception")]
        public async Task RetrieveNotifications_ShouldThrowAnInvalidNotificationRequestExceptionWhenRequestIsNullAsync()
        {
            // Arrange & Act
            var exception = await Assert.ThrowsAsync<InvalidNotificationRequestException>(() => _sut.RetrieveNotifications(null));
            
            // Assert
            Assert.Equal("Invalid RetrieveNotificationRequest object", exception.Message);
        }
        
        
        [Fact(DisplayName = "When a request with a UserId is passed in this should return a list of notifications")]
        public async Task RetrieveNotifications_ShouldReturnAListOfNotificationsAsync()
        {
            // Arrange
            var requestDto = new RetrieveNotificationRequest(
                1
            );
            var responseDto = new RetrieveNotificationsResponse(_mockedListDto);
            
            _notificationRepoMock.Setup(n =>
                n.RetrieveNotifications(requestDto)).ReturnsAsync(_mockedListDto);
           
            // Act
            var notificationList = await _sut.RetrieveNotifications(requestDto);
            
            // Assert
            Assert.Equal(responseDto.Notifications, notificationList.Notifications);
        }
        
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
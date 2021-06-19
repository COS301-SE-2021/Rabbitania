using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using backend_api.Controllers.Notification;
using backend_api.Data.Notification;
using backend_api.Models.Notification;
using backend_api.Models.Notification.Requests;
using FluentAssertions;
using Microsoft.Extensions.DependencyInjection;
using Xunit;

namespace backend_api.Tests.NotificationTests.IntegrationTests
{
    public class NotificationControllerTests: NotificationIntegrationTests
    {
        private readonly DateTime _mockDate;
        
        public NotificationControllerTests()
        {
            _mockDate = DateTime.Now;
        }
        
        [Fact(DisplayName = "Retrieve Notifications should return a list of notification when user exists")]
        public async Task NotificationController_RetrieveNotificationsEndpoint_ShouldReturnNotificationsOfTheUserIfUserExists()
        {
            // Arrange
            
            // Act
            var response = await Http.GetAsync("api/Notifications/RetrieveNotifications?UserId=1");
            
            // Assert
            response.StatusCode.Should().Be(HttpStatusCode.OK);
            (await response.Content.ReadAsAsync<List<Notification>>()).Should().BeEmpty();
        }
        
    }
}
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
using Microsoft.EntityFrameworkCore.TestModels.Inheritance;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json;
using Xunit;

namespace backend_api.Tests.NotificationTests.IntegrationTests
{
    public class NotificationControllerTests: IClassFixture<NotificationIntegrationTests<Startup>>
    {
        private readonly DateTime _mockDate;
        private readonly HttpClient _client;
        
        public NotificationControllerTests(NotificationIntegrationTests<Startup> factory)
        {
            _mockDate = DateTime.Now;
            _client = factory.CreateClient();
        }


        [Fact(DisplayName = "Retrieve Notifications should be an internal server error when user doesn't exist")]
        public async Task NotificationController_RetrieveNotificationsEndpoint_ShouldNotReturnNotificationsOfTheUserIfUserDoesNotExists()
        {
            // Arrange
            var response = await _client.GetAsync("/api/Notifications/RetrieveNotifications?UserId=0");

            // Act
            var resString = await response.Content.ReadAsStringAsync();
            
            //Assert
            Assert.Equal(HttpStatusCode.InternalServerError, response.StatusCode);
        }
        
        [Fact(DisplayName = "Retrieve Notifications should return OK when user exists")]
        public async Task NotificationController_RetrieveNotificationsEndpoint_ShouldReturnNotificationsOfTheUserIfUserExists()
        {
            // Arrange
            var response = await _client.GetAsync("/api/Notifications/RetrieveNotifications?UserId=1");

            // Act
            response.EnsureSuccessStatusCode();
            var resString = await response.Content.ReadAsStringAsync();
            
            //Assert
            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        }

    }
}
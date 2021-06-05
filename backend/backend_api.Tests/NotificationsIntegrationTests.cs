using System;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;
using backend_api.Models;
using Xunit;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.TestHost;
using System.Net.Http;
using Microsoft.AspNetCore.Hosting;

namespace backend_api.Tests
{
    public class NotificationIntegrationTests : IClassFixture<TestFixture<Startup>>
    {
        private HttpClient Client;

        public NotificationIntegrationTests(TestFixture<Startup> fixture)
        {
            Client = fixture.Client;
        }

        [Fact]
        public async Task TestGetNotificationAsync()
        {
            // Arrange
            var request = "api/Notifications";

            // Act
            var response = await Client.GetAsync(request);

            // Assert
            //response.EnsureSuccessStatusCode();
            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        }
        
        
        /*[Fact]
        public async Task TestGetNoticeBoardThreadNotFoundAsync()
        {
            // Arrange
            var request = "api/NoticeBoardThread/1";

            // Act
            var response = await Client.GetAsync(request);

            // Assert
            Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        }*/


        [Fact]
        public async Task TestNotificationPutNotFoundAsync()
        {
            // Arrange
            var request = new
            {
                Url = "api/Notifications/1",
                Body= new
                {
                    notificationID= 0,
                    notificationContent= "string",
                    notificationType= 0,
                    dateCreated= "2021-06-03T12:54:56.897Z",
                    userID= 0
                }
            };

        // Act
        var response = await Client.PutAsync(request.Url, ContentHelper.GetStringContent(request.Body));
        
        // Assert
        Assert.Equal(HttpStatusCode.BadRequest,response.StatusCode);
        }
        
        
        [Fact]
        public async Task TestNotificationPostAsync()
        {
            // Arrange
            var request = new
            {
                Url = "api/Notifications",
                Body= new
                {
                    notificationID= 0,
                    notificationContent= "string",
                    notificationType= 0,
                    dateCreated= "2021-06-03T12:54:56.897Z",
                    userID= 0
                }
            };

            // Act
            var response = await Client.PostAsync(request.Url,ContentHelper.GetStringContent(request.Body));

            // Assert
            response.EnsureSuccessStatusCode();
        }
        
        [Fact]
        public async Task TestNotificationPutAsync()
        {
            // Arrange
            var request = new
            {
                Url = "api/Notifications/0",
                Body= new
                {
                    notificationID= 0,
                    notificationContent= "test update of content",
                    notificationType= 0,
                    dateCreated= "2021-06-03T12:54:56.897Z",
                    userID= 0
                }
            };

            // Act
            var response = await Client.PutAsync(request.Url, ContentHelper.GetStringContent(request.Body));
        
            // Assert
            Assert.Equal(HttpStatusCode.NotFound,response.StatusCode);
        }

        [Fact]
        public async Task TestNotificationDeleteByID()
        {
            var postRequest = new
            {
                Url = "api/NoticeBoardThread/",
                Body = new
                {
                    notificationID= 0,
                    notificationContent= "test update of content",
                    notificationType= 0,
                    dateCreated= "2021-06-03T12:54:56.897Z",
                    userID= 0
                }
            };
            
            // Act
            var postResponse = await Client.PostAsync(postRequest.Url, ContentHelper.GetStringContent(postRequest.Body));
            var jsonFromPost = await postResponse.Content.ReadAsStringAsync();
            NoticeBoardThread temp = await postResponse.Content.ReadAsAsync<NoticeBoardThread>();
            

            var deleteResponse = await Client.DeleteAsync(string.Format("api/NoticeBoardThread/{0}", temp.threadID));

            // Assert
            
            //postResponse.EnsureSuccessStatusCode();
            
            Assert.Equal(HttpStatusCode.Created, postResponse.StatusCode);
            
            //deleteResponse.EnsureSuccessStatusCode();
            
            Assert.Equal(HttpStatusCode.NoContent, deleteResponse.StatusCode);
        }
    }
}
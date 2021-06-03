using System;
using System.Collections.Generic;
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
    public class UserIntegrationTest : IClassFixture<TestFixture<Startup>>
    {
        private HttpClient Client;

        public UserIntegrationTest(TestFixture<Startup> fixture)
        {
            Client = fixture.Client;
        }

        [Fact]
        public async Task TestGetUsersAsync()
        {
            // Arrange
            var request = "/api/User";

            // Act
            var response = await Client.GetAsync(request);

            // Assert
            response.EnsureSuccessStatusCode();
            //Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        }
        [Fact]
        public async Task TestGetUserAsync()
        {
            // Arrange
            var request = "/api/User/1";

            // Act
            var response = await Client.GetAsync(request);

            // Assert
            response.EnsureSuccessStatusCode();
            //Assert.Equal(HttpStatusCode.InternalServerError, response.StatusCode);
        }
        [Fact]
        public async Task TestPostUserAsync()
        {
            // Arrange
            var request = new
            {
                Url = "/api/User",
                Body = new
                {
                    userID = 0,
                    firstname = "Integration",
                    lastname = "test2",
                    phoneNumber = "1234567890",
                    pinnedUserIDs = new List<int>{1,2},
                    userImage = "Image.png",
                    userDescription = "Integration test user",
                    isOnline = false,
                    isAdmin = true,
                    employeeLevel = 4,
                    userRoles = 0,
                    officeLocation = 0
                    //Tags = "[\"32GB\",\"USB Powered\"]"
                    /*"userID": 0,
                    "firstname": "string",
                    "lastname": "string",
                    "phoneNumber": "string",
                    "pinnedUserIDs": [
                    0
                    ],
                    "userImage": "string",
                    "userDescription": "string",
                    "isOnline": true,
                    "isAdmin": true,
                    "employeeLevel": 0,
                    "userRoles": 0,
                    "officeLocation": 0,
                    "userEmails": [
                    0
                    ] */
                }
            };

            // Act
            var response = await Client.PostAsync(request.Url, ContentHelper.GetStringContent(request.Body));
            var value = await response.Content.ReadAsStringAsync();

            // Assert
             response.EnsureSuccessStatusCode();
            //Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        }
        [Fact]
        public async Task TestPostUserExistsAsync()
        {
            // Arrange
            var request = new
            {
                Url = "/api/User",
                Body = new
                {
                    userID = 1,
                    firstname = "Integration",
                    lastname = "test2",
                    phoneNumber = "1234567890",
                    pinnedUserIDs = new List<int>{1,2},
                    userImage = "Image.png",
                    userDescription = "Integration test user",
                    isOnline = false,
                    isAdmin = true,
                    employeeLevel = 4,
                    userRoles = 0,
                    officeLocation = 0,
                    userEmails = new List<int>{1},
                }
            };

            // Act
            var response = await Client.PostAsync(request.Url, ContentHelper.GetStringContent(request.Body));
            var value = await response.Content.ReadAsStringAsync();

            // Assert
            //response.EnsureSuccessStatusCode();
            Assert.Equal(HttpStatusCode.InternalServerError, response.StatusCode);
        }
        
        [Fact]
        public async Task TestPutUserAsync()
        {
            // Arrange
            var request = new
            {
                Url = "/api/User/1",
                Body = new
                {
                    userID = 1,
                    firstname = "Updated User",
                    lastname = "test2",
                    phoneNumber = "111111111",
                    pinnedUserIDs = new List<int>{1,2},
                    userImage = "ImageUpdated.png",
                    userDescription = "Integration test user",
                    isOnline = false,
                    isAdmin = true,
                    employeeLevel = 4,
                    userRoles = 0,
                    officeLocation = 0,
                    userEmails = new List<int>{1},
                }
            };

            // Act
            var response = await Client.PutAsync(request.Url, ContentHelper.GetStringContent(request.Body));

            // Assert
            response.EnsureSuccessStatusCode();
        }
        // public async Task TestPutNoticeBoardThreadAsync()
        // {
        //     // Arrange
        //     var request = new
        //     {
        //         Url = "api/NoticeBoardThread/0",
        //         Body= new
        //         {
        //             threadID= 0,
        //             threadTitle= "newTestTitleForUpdate",
        //             threadContent= "test thread content",
        //             threadCreationDate= "2021/05/21",
        //             threadDueDate= "2021/05/21",
        //             userID= 0
        //         }
        //     };
        //
        //     // Act
        //     var response = await Client.PutAsync(request.Url, ContentHelper.GetStringContent(request.Body));
        //
        //     // Assert
        //     Assert.Equal(HttpStatusCode.NotFound,response.StatusCode);
        // }
        [Fact]
        public async Task TestDeleteUserAsync()
        {
            // Arrange

            var postRequest = new
            {
                Url = "/api/User",
                Body = new
                {
                    userID = 0,
                    firstname = "Integration2",
                    lastname = "test2",
                    phoneNumber = "1234567890",
                    pinnedUserIDs = new List<int>{1,2},
                    userImage = "Image2.png",
                    userDescription = "Integration test user2",
                    isOnline = false,
                    isAdmin = true,
                    employeeLevel = 4,
                    userRoles = 0,
                    officeLocation = 0,
                    userEmails = new List<int>{1}
                }
            };
            
            // Act
            var postResponse = await Client.PostAsync(postRequest.Url, ContentHelper.GetStringContent(postRequest.Body));
            var jsonFromPost = await postResponse.Content.ReadAsStringAsync();
            User temp = await postResponse.Content.ReadAsAsync<User>();
            

            var deleteResponse = await Client.DeleteAsync(string.Format("/api/User/{0}", temp.UserID));
            // Assert
            //postResponse.EnsureSuccessStatusCode();
            Assert.Equal(HttpStatusCode.Created, postResponse.StatusCode);
            //deleteResponse.EnsureSuccessStatusCode();
            Assert.Equal(HttpStatusCode.NoContent, deleteResponse.StatusCode);
        }
    }
}
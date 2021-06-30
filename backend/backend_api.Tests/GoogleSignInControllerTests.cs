using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using backend_api.Exceptions.Auth;
using backend_api.Models.User.Responses;
using Microsoft.AspNetCore.Http;
using Xunit;

namespace backend_api.Tests
{
    public class GoogleSignInControllerTests: AuthIntegrationTests
    {
        [Fact(DisplayName = "Attempt to get ID with invalid email")]
        public async Task GetIDEndpoint_invalidEmail()
        {
            //Arrange
            
            //Act
            var response = await _client.GetAsync("/api/GoogleSignIn/GetID?UserId=0");
            //Assert
            Assert.Equal(HttpStatusCode.InternalServerError, response.StatusCode);
            Assert.NotNull(response);
        }
        [Fact(DisplayName = "Attempt to get ID with a valid email")]
        public async Task GetIDEndpoint_ValidEmail()
        {
            //Arrange
            
            //Act
            var response = await _client.GetAsync("/api/GoogleSignIn/GetID?UserId=1");
            response.EnsureSuccessStatusCode();
            //Assert
            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
            Assert.NotNull(response);
        }
    }
}
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Exceptions.User;
using backend_api.Models.NoticeBoard;
using backend_api.Models.User;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using backend_api.Services.User;
using Moq;
using Xunit;

namespace backend_api.Tests
{
    public class ViewProfileUnitTests
    {
        private readonly UserService _sut;
        private readonly Mock<IUserRepository> _userRepoMock = new Mock<IUserRepository>();

        public ViewProfileUnitTests()
        {
            _sut = new UserService(_userRepoMock.Object);
        }
        [Fact(DisplayName = "When the ViewProfileRequest is null, an exception should be thrown")]
        public async Task ViewProfile_ThrowInvalidUserRequestOnNullObject()
        {
            var exception =
                await Assert.ThrowsAsync<InvalidUserRequest>(
                    () => _sut.ViewProfile(null));
            Assert.Equal("Request object cannot be null", exception.Message);
        }

        [Fact(DisplayName = "Return Profile of User if userID is valid")]
        public async Task ViewProfile_ReturnStatusCodeAccepted()
        {
            var requestDto = new ViewProfileRequest(1);
            var responseDto = new ViewProfileResponse(HttpStatusCode.Accepted);
            //_userRepoMock.Setup(n => n.ViewProfile(requestDto)).Returns(responseDto.respons);

            var profile = await _sut.ViewProfile(requestDto);
            Assert.Equal(responseDto.response, profile.response);
        }
    }
}
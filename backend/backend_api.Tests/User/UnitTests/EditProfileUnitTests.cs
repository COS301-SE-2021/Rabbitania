using System.Net;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Exceptions.Notifications;
using backend_api.Exceptions.User;
using backend_api.Models.Enumerations;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using backend_api.Services.User;
using Moq;
using Xunit;

namespace backend_api.Tests.User.UnitTests
{
    public class EditProfileUnitTests
    {
        private readonly UserService _sut;
        private readonly Mock<IUserRepository> _userRepoMock = new Mock<IUserRepository>();

        public EditProfileUnitTests()
        {
            _sut = new UserService(_userRepoMock.Object);
        }

        [Fact(DisplayName = "When the request object is null, Invalid User Request error must be thrown")]
        public async Task EditUser_ExceptionOnNullRequestObject()
        {
            var exception = await Assert.ThrowsAsync<InvalidUserRequest>(() => _sut.EditProfile(null));
            Assert.Equal("Request object cannot be null", exception.Message);
        }

        [Fact(DisplayName = "When a user profile is edited, it should return HTTPStatusCODE 201 (Accepted")]
        public async Task EditUserProfile_ExpectedReturnStatus()
        {
            var requestDto = new EditProfileRequest(
                1,
                "name",
                "0833611023",
                "image.png",
                "user Description",
                false,
                4,
                UserRoles.Administrator,
                OfficeLocation.Braamfontein
            );
            var responseDto = new EditProfileResponse(HttpStatusCode.Accepted);
            _userRepoMock.Setup(n => n.EditProfile(requestDto)).ReturnsAsync(responseDto);
            var editedUserProfile = await _sut.EditProfile(requestDto);
            Assert.Equal(responseDto, editedUserProfile);
        }

        [Fact(DisplayName =
            "If the request object has a userId equal to or less than 0, throw an invalid userId exception")]
        public async Task EditProfile_ExceptionOnInvalidUserID()
        {
            var requestDto = new EditProfileRequest(
                0,
                "name",
                "0833611023",
                "image.png",
                "user Description",
                false,
                4,
                UserRoles.Administrator,
                OfficeLocation.Braamfontein
            );

            var exception = await Assert.ThrowsAsync<InvalidUserIdException>(() => _sut.EditProfile(requestDto));
            Assert.Equal("UserID is invalid", exception.Message);
        }
        

    }
}
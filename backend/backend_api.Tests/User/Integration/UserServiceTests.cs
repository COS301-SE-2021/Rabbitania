using System;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Exceptions.Notifications;
using backend_api.Exceptions.User;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Enumerations;
using backend_api.Models.User.Requests;
using backend_api.Services.User;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Xunit;

namespace backend_api.Tests.User.Integration
{
    public class UserServiceTests
    {
        private readonly UserContext _userContext;
        private readonly IUserRepository _userRepository;
        private readonly IUserService _userService;

        public UserServiceTests()
        {
            var serviceProvider = new ServiceCollection().AddEntityFrameworkNpgsql().BuildServiceProvider();
            var builder = new DbContextOptionsBuilder<UserContext>();
            var env = Environment.GetEnvironmentVariable("CONN_STRING");
            builder.UseNpgsql(env.ToString())
                .UseInternalServiceProvider(serviceProvider);

            _userContext = new UserContext(builder.Options);
            _userRepository = new UserRepository(_userContext);
            _userService = new UserService(_userRepository);
        }

        /// <summary>
        ///     Inserts a mock User into the testing DB so that there
        ///     is a specific User to be deleted each time the tests
        ///     are executed.
        /// </summary>

//--------------------------------------CreateUser-------------------------------------
        [Fact]
        public async void CreateUser_InvalidRequest_NullRequest()
        {
            //Arrange

            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.CreateUser(null));
        }

        [Fact]
        public async void CreateUser_InvalidRequest_InvalidEmail()
        {
            //Arrange
            var request = new GoogleSignInRequest("");
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserEmailRequest>(async () => await _userService.CreateUser(request));
        }

        [Fact]
        public async void CreateUser_ValidRequest()
        {
            //Arrange
            var request = new GoogleSignInRequest("Integration test", "integrationTest@tuks.co.za", "1234567890",
                "image.png");
            //Act
            var resp = await _userService.CreateUser(request);
            //Assert
            Assert.Equal("User Successfully Created", resp.Response);
        }

//---------------------------------------GetUser-------------------------------------
        [Fact]
        public async void GetUser_InvalidRequest_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.getUser(null));
        }

        [Fact]
        public async void GetUser_InvalidRequest_EmptyName()
        {
            //Arrange
            var request = new GetUserRequest(null, "test");
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.getUser(request));
        }

        [Fact]
        public async void GetUser_InvalidRequest_EmptySurnname()
        {
            //Arrange
            var request = new GetUserRequest("test", null);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.getUser(request));
        }

        [Fact]
        public async void GetUser_ValidRequest_InvalidUser()
        {
            //Arrange
            var request = new GetUserRequest("test", "null");
            //Act
            //var resp = await _userService.getUser(request);
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.getUser(request));
        }

        [Fact]
        public async void GetUser_ValidRequest_ValidUser()
        {
            //Arrange
            var request = new GetUserRequest("Integration test", "null");
            //Act
            var resp = await _userService.getUser(request);
            //Assert
            Assert.NotNull(resp);
        }

//-------------------------GetUserByEmail-----------------------------------
        [Fact]
        public async void GetUserByEmail_InvalidRequest_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.GetUserByEmail(null));
        }

        [Fact]
        public async void GetUserByEmail_InvalidRequest_NullEmail()
        {
            //Arrange
            var request = new GetUserByEmailRequest();
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserEmailRequest>(async () => await _userService.GetUserByEmail(request));
        }

        [Fact]
        public async void GetUserByEmail_InvalidRequest_EmptyEmail()
        {
            //Arrange
            var request = new GetUserByEmailRequest("");
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserEmailRequest>(async () => await _userService.GetUserByEmail(request));
        }

        [Fact]
        public async void GetUserByEmail_ValidRequest_EmailDoesntExist()
        {
            //Arrange
            var request = new GetUserByEmailRequest("t@tuks.co.za");
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserEmailRequest>(async () => await _userService.GetUserByEmail(request));
        }

        [Fact]
        public async void GetUserByEmail_ValidRequest_UserExists()
        {
            //Arrange
            var request = new GetUserByEmailRequest("integrationTest@tuks.co.za");
            //Act
            var resp = await _userService.GetUserByEmail(request);
            //Assert
            Assert.NotNull(resp);
        }

//----------------------------------EditProfile------------------------------
        [Fact]
        public async void EditProfile_InvalidRequest_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.EditProfile(null));
        }

        [Fact]
        public async void EditProfile_InvalidRequest_UserIDNUll()
        {
            //Arrange
            var request = new EditProfileRequest();
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserIdException>(async () => await _userService.EditProfile(request));
        }

        [Fact]
        public async void EditProfile_ValidRequest_InvalidUser()
        {
            //Arrange
            var request = new EditProfileRequest(19999, "test", "12121212", "Test", "", false, 3, UserRoles.Developer,
                OfficeLocation.Pretoria);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.EditProfile(request));
        }

        [Fact]
        public async void EditProfile_ValidRequest_ValidUser()
        {
            //Arrange
            var request = new EditProfileRequest(2, "test3", "12121212", "Integration update est", "", false, 3,
                UserRoles.Developer, OfficeLocation.Pretoria);
            //Act
            var resp = await _userService.EditProfile(request);
            //Assert
            Assert.Equal(HttpStatusCode.Accepted, resp.Response);
        }

//--------------------------------------ViewProfile----------------------------------
        [Fact]
        public async void ViewProfile_InvalidRequest_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.ViewProfile(null));
        }

        [Fact]
        public async void ViewProfile_InvalidRequest_NegativeID()
        {
            //Arrange
            var request = new ViewProfileRequest(-1);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserIdException>(async () => await _userService.ViewProfile(request));
        }

        [Fact]
        public async void ViewProfile_InvalidRequest_ZeroID()
        {
            //Arrange
            var request = new ViewProfileRequest(0);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserIdException>(async () => await _userService.ViewProfile(request));
        }

        [Fact]
        public async void ViewProfile_ValidRequest_UserDoesntExist()
        {
            //Arrange
            var request = new ViewProfileRequest(200000);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.ViewProfile(request));
        }

        [Fact]
        public async void ViewProfile_ValidRequest_ValidUser()
        {
            //Arrange
            var request = new ViewProfileRequest(1);
            //Act
            var resp = await _userService.ViewProfile(request);
            //Assert
            Assert.Equal("test", resp.name);
        }

        //--------------------------------------GetUserProfiles----------------------------------
        [Fact]
        public async void GetUserProfiles_InvalidRequest_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.GetUserProfiles(null));
        }
        [Fact]
        public async void GetUserProfiles_ValidRequest()
        {
            //Arrange
            var request = new GetUserProfilesRequest();
            //Act
            var resp = await _userService.GetUserProfiles(request);
            //Assert
            Assert.NotNull(resp);
        }
        //--------------------------------------GetAllUserEmails----------------------------------
        [Fact]
        public async void GetAllUserEmails()
        {
            //Arrange
            //Act
            //Assert
            Assert.NotNull(_userService.GetAllUserEmails());
        }
        //--------------------------------------MakeUserAdmin----------------------------------
        [Fact]
        public async void MakeUserAdmin_InvalidRequest_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.MakeUserAdmin(null));
        }
        [Fact]
        public async void MakeUserAdmin_InvalidRequest_NegativeID()
        {
            //Arrange
            var request = new MakeUserAdminRequest(-1);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserIdException>(async () => await _userService.MakeUserAdmin(request));
        }
        [Fact]
        public async void MakeUserAdmin_InvalidRequest_ZeroID()
        {
            //Arrange
            var request = new MakeUserAdminRequest(0);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserIdException>(async () => await _userService.MakeUserAdmin(request));
        }
        [Fact]
        public async void MakeUserAdmin_ValidRequest_InvalidUser()
        {
            //Arrange
            var request = new MakeUserAdminRequest(1000902);
            //Act
            var resp = await _userService.MakeUserAdmin(request);
            //Assert
            Assert.Equal(HttpStatusCode.BadRequest, resp.StatusCode);
        }
        [Fact]
        public async void MakeUserAdmin_ValidRequest()
        {
            //Arrange
            var request = new MakeUserAdminRequest(1);
            //Act
            var resp = await _userService.MakeUserAdmin(request);
            //Assert
            Assert.Equal(HttpStatusCode.OK, resp.StatusCode);
        }
        //--------------------------------------CheckAdmin----------------------------------
        [Fact]
        public async void CheckAdmin_InvalidRequest_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.CheckAdmin(null));
        }
        [Fact]
        public async void CheckAdmin_InvalidRequest_InvalidEmail()
        {
            //Arrange
            var request = new CheckAdminStatusRequest("");
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequestException>(async () => await _userService.CheckAdmin(request));
        }

        [Fact]
        public async void CheckAdmin_ValidRequest_InvalidUser()
        {
            //Arrange
            var request = new CheckAdminStatusRequest("t@tuks.co.za");
            //Act
            var resp = await _userService.CheckAdmin(request);
            //Assert
            Assert.Equal(HttpStatusCode.BadRequest, resp.Status);
        }
        [Fact]
        public async void CheckAdmin_ValidRequest_ValidUser()
        {
            //Arrange
            var request = new CheckAdminStatusRequest("integrationTest@tuks.co.za");
            //Act
            var resp = await _userService.CheckAdmin(request);
            //Assert
            Assert.Equal(HttpStatusCode.OK, resp.Status);
            Assert.False(resp.Result);
        }
    }
}
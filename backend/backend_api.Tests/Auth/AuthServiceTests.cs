using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Exceptions.Auth;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using backend_api.Models.User;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using backend_api.Services.Auth;
using Moq;
using Xunit;
using Xunit.Abstractions;
using Xunit.Sdk;

namespace backend_api.Tests.Auth
{
    namespace backend_api.Tests
{
    public class AuthUniTests
    {
        private readonly AuthService _authService;
        private readonly Mock<IUserRepository> _userRepositoryMock = new Mock<IUserRepository>();
        private readonly ITestOutputHelper outHelper;
        public AuthUniTests(ITestOutputHelper outHelp)
        {
            _authService = new AuthService(_userRepositoryMock.Object);
            this.outHelper = outHelp;
        }
        
        [Fact]
        public void InvalidDomainLogin()
        {
            //Arrange
            string email = "test@gmail.com";
            GoogleSignInRequest request1 = new GoogleSignInRequest(email);
            
            //Act
            var response = _authService.CheckEmailDomain(request1);
            
            //Assert
            Assert.NotNull(response);
            Assert.IsType<DomainResponse>(response);
            Assert.Equal(false, response.CorrectDomain);
        }

        [Fact(DisplayName = "Should be true if a 'castellodev.co.za' is used to login")]
        public void CorrectDomainLogin()
        {
            //Arrange
            string email = "test@castellodev.co.za";
            GoogleSignInRequest request1 = new GoogleSignInRequest(email);
            
            //Act
            var response = _authService.CheckEmailDomain(request1);
            
            //Assert
            Assert.NotNull(response);
            Assert.IsType<DomainResponse>(response);
            Assert.Equal(true, response.CorrectDomain);
        }
        
        [Fact(DisplayName = "Should throw an exception for an invalid email in the database")]
        public void InvalidEmailLogin()
        {
            //Arrange
            // int userID = 50;
            // var name = "unit";
            // var surname = "test";
            // var phone = 1234567890;
            // var pinnedIds = new List<int>(){1,2};
            // var userImage = "test.png";
            // var desc = "test description";
            // var online = true;
            // var admin = false;
            // var empLevel = 4;
            // UserRoles role = UserRoles.Developer;
            // OfficeLocation location = OfficeLocation.Pretoria;
            // var newUserRequest = new CreateUserRequest(userID, name, surname, phone, pinnedIds, userImage,desc, online, admin, empLevel, role, location);
            var email = "hi@castellodev.co.za";
            var emailID = 10;
            var displayName = "unit test";
            var image = "unitTest.png";
            var phone = "1234567890";
           
            var signInRequest = new GoogleSignInRequest(displayName, email, phone, image);
            var request2 = new GoogleSignInRequest(
                "check",
                "check@castellodev.co.za",
                "1234567899",
                "test.png");
           
            _userRepositoryMock.Setup(x => x.CreateUser(signInRequest));

            //Act
            var response = _authService.checkEmailExists(request2);
            
            //Assert
            Assert.IsType<LoginResponse>(response);
            Assert.Equal(false,response.EmailExists);

        }

        [Fact(DisplayName = "If the email is null, a null email exception is thrown")]
        public void CheckNullEmail()
        {
            //Arrange
            var request = new GoogleSignInRequest(
                "check",
                null, 
                "1234567899",
                "test.png");
            //Act
            
            //Assert
            Assert.Throws<NullEmailException>(() => _authService.checkEmailExists(request));
        }

        [Fact(DisplayName = "Should be true if the user already exists in the system")]
        public void CheckCorrectEmail()
        {
            //Arrange
            var email = "hi@castellodev.co.za";
            var displayName = "unit test";
            var image = "unitTest.png";
            var phone = "1234567890";
           
            var signInRequest = new GoogleSignInRequest(displayName, email, phone, image);
           
            _userRepositoryMock.Setup(x => x.CreateUser(signInRequest)).ReturnsAsync(new CreateUserResponse());
            
            //Act
            var response = _authService.checkEmailExists(signInRequest);
            
            //Assert
             Assert.IsType<LoginResponse>(response);
             Assert.True(response.EmailExists);
        }

        /*[Fact(DisplayName = "Gets a user json object that exists on the system")]
        public void getUser()
        {
            //Arrange
            var email = "hi@castellodev.co.za";
            var displayName = "unit test";
            var image = "unitTest.png";
            var phone = "1234567890";
           
            var signInRequest = new GoogleSignInRequest(displayName, email, phone, image);
            var request2 = new GoogleSignInRequest("check", "hi@castellodev.co.za", "1234567899", "test.png");
            _userRepositoryMock.Setup(x => x.CreateUser(signInRequest)).Verifiable();
            //Act
            var resp = _authService.GetUser(signInRequest);
            //Assert
            Assert.NotNull(resp);
        }*/
    }
}
}
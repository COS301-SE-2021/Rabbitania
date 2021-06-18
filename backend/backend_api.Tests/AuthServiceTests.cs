using System;
using System.Collections.Generic;
using backend_api.Data.User;
using backend_api.Exceptions.Auth;
using backend_api.Models;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using backend_api.Models.User;
using backend_api.Models.User.Requests;
using backend_api.Services.Auth;
using Moq; 
using Xunit;
using Xunit.Sdk;

/*namespace backend_api.Tests
{
    public class AuthUniTests
    {
        private readonly AuthService _authService;
        private readonly Mock<IUserRepository> _userRepositoryMock = new Mock<IUserRepository>();
        public AuthUniTests()
        {
            _authService = new AuthService(_userRepositoryMock.Object);
        }
        
        [Fact]
        public void InvalidDomainLogin()
        {
            //Arrange
            String email = "test@gmail.com";
            GoogleSignInRequest request1 = new GoogleSignInRequest(email);
            
            //Act
            var response = _authService.CheckEmailDomain(request1);
            //Assert
            Assert.NotNull(response);
            Assert.IsType<DomainResponse>(response);
        }
        //TODO: finish test
        [Fact]
        public void invalidEmailLogin()
        {
            //Arrange
            int userID = 50;
            var name = "unit";
            var surname = "test";
            var phone = 1234567890;
            var pinnedIds = new List<int>(){1,2};
            var userImage = "test.png";
            var desc = "test description";
            var online = true;
            var admin = false;
            var empLevel = 4;
            UserRoles role = UserRoles.Developer;
            OfficeLocation location = OfficeLocation.Pretoria;
            var newUserRequest = new CreateUserRequest(userID, name, surname, phone, pinnedIds, userImage,desc, online, admin, empLevel, role, location);
            String email = "hi@castellodev.co.za";
            var emailID = 10;
            var newEmailRequest = new CreateEmailRequest(email, emailID);
            
            //Act
            var response1 = _userRepositoryMock.Setup(x => x.CreateUser(newUserRequest));
            var response2 = _userRepositoryMock.Setup(x => x.CreateUserEmail(newUserRequest, newEmailRequest));
            
            //Assert
            Assert.IsType<LoginResponse>(response2);

        }
        //TODO: Check why I get a TestClassException error
        
    }
    
}*/
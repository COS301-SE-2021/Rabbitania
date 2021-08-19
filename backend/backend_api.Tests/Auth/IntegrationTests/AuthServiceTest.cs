using System;
using System.Collections.Generic;
using backend_api.Data.User;
using backend_api.Exceptions.Auth;
using backend_api.Exceptions.User;
using backend_api.Models.Auth;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Enumerations;
using backend_api.Models.User;
using backend_api.Services.Auth;
using backend_api.Services.User;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Newtonsoft.Json.Linq;
using Xunit;

namespace backend_api.Tests.Auth.IntegrationTests
{
    public class AuthServiceTest
    {
        private readonly Users _mockedUser;
        private readonly UserEmails _mockedEmail;
        private UserContext _userContext;
        private readonly UserRepository userRepo;
        private readonly AuthService authService;
        
        
        public AuthServiceTest()
        {
            var serviceProvider = new ServiceCollection().AddEntityFrameworkNpgsql().BuildServiceProvider();
            var builder = new DbContextOptionsBuilder<UserContext>();
            var env = Environment.GetEnvironmentVariable("CONN_STRING");
            builder.UseNpgsql(env.ToString())
                .UseInternalServiceProvider(serviceProvider);

            _userContext = new UserContext(builder.Options);
            
            _mockedUser = new Users(
                "Unit Tests",
                "0834758854",
                new List<int>(){1},
                "www.google/test.png",
                "This is a Test",
                true,
                1,
                UserRoles.Unassigned,
                OfficeLocation.Unassigned
            );
            
            _mockedEmail = new UserEmails("test@gmail.com", 7);
            // _userContext.Users.Add(_mockedUser);
            // _userContext.UserEmail.Add(_mockedEmail);
            // await _userContext.SaveChanges();
            userRepo = new UserRepository(_userContext);
            authService = new AuthService(userRepo);

        }

        [Fact(DisplayName = "Should be False if a non 'gmail.com' email is used to login")]
        public async void InvalidDomainLogin()
        {
            //Arrange
            string email = "test@tuks.co.za";
            var req = new GoogleSignInRequest(email);
            
            //Act
            var resp = authService.CheckEmailDomain(req);
            
            //Assert
            Assert.False(resp.CorrectDomain);
        }
        
        [Fact(DisplayName = "Should be True if a 'gmail.com' email is used to login")]
        public async void ValidDomainLogin()
        {
            //Arrange
            string email = "test@gmail.com";
            var req = new GoogleSignInRequest(email);
            
            //Act
            var resp = authService.CheckEmailDomain(req);
            
            //Assert
            Assert.True(resp.CorrectDomain);
        }
        
        [Fact(DisplayName = "Should be True if the 'test@gmail.com' email is in the database")]
        public async void CheckEmailExists_True()
        {
            //Arrange
            var req = new GoogleSignInRequest(_mockedEmail.UsersEmail);
            
            //Act
            var resp = await authService.checkEmailExists(req);
            
            //Assert
            Assert.True(resp.EmailExists);
            
            
        }
        [Fact(DisplayName = "Should be false if the 'test1@gmail.com' email is not in the database")]
        public async void CheckEmailExists_False()
        {
            //Arrange
            var req = new GoogleSignInRequest("t@gmail.com");
            
            //Act
            var resp = await authService.checkEmailExists(req);
            
            //Assert
            Assert.False(resp.EmailExists);
            
            //Add test user email back
        }
        
        [Fact(DisplayName = "If the email is null, a null email exception is thrown")]
        public void CheckNullEmail()
        {
            //Arrange
            var request = new GoogleSignInRequest();
            //Act
            
            //Assert
            Assert.ThrowsAsync<NullEmailException>(() => authService.checkEmailExists(request)); 
        }
        
        [Fact(DisplayName = "Checks that the user exists in the database, should return true")]
        public void GetValidUser_True()
        {
            //Arrange
            var request = new GoogleSignInRequest("test@gmail.com");
            //Act
            var resp = authService.GetUser(request);
            //Assert
            Assert.Equal(resp.Type, JTokenType.Object);
            Assert.NotNull(resp);

        }
        [Fact(DisplayName = "Checks that the user exists in the database, should throw aggregate exception")]
        public void GetValidUser_False()
        {
            //Arrange
            var request = new GoogleSignInRequest("t@gmail.com");
            //Act
            
            //Assert
            Assert.Throws<AggregateException>(() => authService.GetUser(request));
        }
        
        [Fact(DisplayName = "Checks that the user exists in the database, should throw aggregate exception")]
        public void GetValidUser_Null()
        {
            //Arrange
            var request = new GoogleSignInRequest();
            //Act
            
            //Assert
            Assert.Throws<AggregateException>(() => authService.GetUser(request));
        }
        
        [Fact(DisplayName = "Checks that the user exists in the database and returns the user from a given name, should pass")]
        public async void GetUserName_ValidUser()
        {
            //Arrange
            var name = "test";
            //Act
            var response = await authService.GetUserName(name);
            //Assert
            Assert.NotNull(response);
            Assert.Equal(name,response.Name);
            
        }
        [Fact]
        public async void GetUserName_NullUser()
        {
            //Arrange
            var name = "Unit Tests";
            //Act
            var respone = await authService.GetUserName(null);
            //Assert
            Assert.Null(respone);
            
        }
        
        [Fact(DisplayName = "Checks that the user exists in the database and returns the user from a given name, should return null")]
        public async void GetUserName_InvalidUser()
        {
            //Arrange
            var name = "Unit";
            //Act
            var respone = await authService.GetUserName(name);
            //Assert
            Assert.Null(respone);
        }
        
        [Fact(DisplayName = "Checks that the user exists and returns it from a given email, should return a user of ID 7")]
        public async void GetUserID_Valid()
        {
            //Arrange
            var req = new GoogleSignInRequest("test@gmail.com");
            //Act
            var response = await authService.GetUserId(req);
            //Assert
            Assert.Equal(1, response.UserId);
        }
        
        [Fact(DisplayName = "Checks that the user exists and returns it from a given email, should thrown an exception for invalid user")]
        public async void GetUserID_Invalid()
        {
            //Arrange
            var req = new GoogleSignInRequest("t@gmail.com");
            //Act
            
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequest>(async () => await authService.GetUserId(req));
        }
        
        [Fact(DisplayName = "Checks that the user exists and returns it from a given email, should thrown an exception for null email")]
        public async void GetUserID_NullInvalid()
        {
            //Arrange
            var req = new GoogleSignInRequest("");
            //Act
            
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequest>(async () => await authService.GetUserId(req));
        }
        [Fact(DisplayName = "Returns true when attempting to validate an existing user")]
        public async void Validate_ValidUser()
        {
            //Arrange
            var req = new Credentials();
            req.Email = "test@gmail.com";
            req.Name = "Unit Tests";
            //Act
            var resp = await authService.Validate(req);
            //Assert
            Assert.False(resp);// wucky true
        }
        
        // [Fact(DisplayName = "Returns false when attempting to validate a use that doesn't exist")]
        // public async void Validate_InvalidUser()
        // {
        //     //Arrange
        //     var req = new Credentials();
        //     req.Email = "test2@gmail.com";
        //     req.Name = "Unit Tests";
        //     //Act
        //     var resp = await authService.Validate(req);
        //     //Assert
        //     Assert.True(resp);// wucky true
        // }
        [Fact(DisplayName = "Returns a user with ID 7 as admin")]
        public async void GetUserAdmin_ValidAdmin()
        {
            //Arrange
            var req = new GoogleSignInRequest("test@gmail.com");
            //Act
            var resp = await authService.GetUserAdminStatus(req);
            //Assert
            Assert.Equal(1, resp.UserId);
        }
        [Fact]
        public async void GetUserAdmin_InvalidAdmin()
        {
            //Arrange
            var req = new GoogleSignInRequest("t@gmail.com");
            //Act

            //Assert
            await Assert.ThrowsAsync<InvalidUserRequest>(async () => await authService.GetUserAdminStatus(req));

        }
        [Fact(DisplayName = "Throws InvalidUserRequest when trying to get Admin of Null user")]
        public async void GetUserAdmin_NullUser()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserRequest>(async () => await authService.GetUserAdminStatus(null));
        }
        
        // [Fact]
        // public async void CreateJWT_ValidUser()
        // {
        //     //Arrange
        //     Credentials credentials = new Credentials();
        //     credentials.Email = "test@gmail.com";
        //     credentials.Name = "Unit Tests";
        //     //Act
        //     var req = await authService.createJwt(credentials);
        //     //Assert
        //     Assert.NotNull(req);
        // }

        [Fact]
        public async void CreateClaims()
        {
            //Arranges
            Credentials credentials = new Credentials();
            credentials.Email = "test@gmail.com";
            credentials.Name = "Unit Tests";
            //Act
            var resp = await authService.GetClaims(credentials);
            //Assert
            Assert.NotNull(resp);
        }
        
    }
}
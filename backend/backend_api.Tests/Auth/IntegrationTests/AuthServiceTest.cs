using System.Collections.Generic;
using backend_api.Data.User;
using backend_api.Exceptions.Auth;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Enumerations;
using backend_api.Models.User;
using backend_api.Services.Auth;
using backend_api.Services.User;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
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
            
            builder.UseNpgsql("Server=localhost;Port=5432;Database=RabbitaniaTesting;Username=postgres;Password=1234")
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
            _userContext.UserEmail.Add(_mockedEmail);
            await _userContext.SaveChanges();
            
            var req = new GoogleSignInRequest(_mockedEmail.UsersEmail);
            
            //Act
            var resp = await authService.checkEmailExists(req);
            
            //Assert
            Assert.True(resp.EmailExists);
            
            //Remove test user
            _userContext.UserEmail.Remove(_mockedEmail);
            await _userContext.SaveChanges();
        }
        [Fact(DisplayName = "Should be false if the 'test1@gmail.com' email is not in the database")]
        public async void CheckEmailExists_False()
        {
            //Arrange
            var req = new GoogleSignInRequest("test1@gmail.com");
            
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
        
        
    }
}
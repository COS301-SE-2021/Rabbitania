using System.Collections.Generic;
using backend_api.Data.User;
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
       // private readonly AuthService _authService;
        //private readonly IUserService _userService;
        private readonly Users _mockedUser;
        private readonly UserEmails _mockedEmail;
        private UserContext _userContext;
        
        
        public AuthServiceTest()
        {
            var serviceProvider = new ServiceCollection().AddEntityFrameworkNpgsql().BuildServiceProvider();
            var builder = new DbContextOptionsBuilder<UserContext>();
            
            builder.UseNpgsql("Server=localhost;Port=5432;Database=RabbitaniaTesting;Username=postgres;Password=1234")
                .UseInternalServiceProvider(serviceProvider);

            _userContext = new UserContext(builder.Options);
            
            // this._mockedUser = new Users(
            //     "Unit Tests",
            //     "0834758854",
            //     new List<int>(){1},
            //     "www.google/test.png",
            //     "This is a Test",
            //     true,
            //     1,
            //     UserRoles.Unassigned,
            //     OfficeLocation.Unassigned
            // );
            
            this._mockedEmail = new UserEmails("test@gnail.com", 50);
           
            
        }

        [Fact(DisplayName = "Should be False if a non 'gmail.com' email is used to login")]
        public async void InvalidDomainLogin()
        {
            _userContext.Users.Add(_mockedUser);
            _userContext.UserEmail.Add(_mockedEmail);
            await _userContext.SaveChanges();
            var userRepo = new UserRepository(_userContext);
            
            var authService = new AuthService(userRepo);
            
            //Arrange
            string email = "test@tuks.co.za";
            var req = new GoogleSignInRequest(email);
            //Act
            var resp = authService.CheckEmailDomain(req);
            
            //Assert
            Assert.False(resp.CorrectDomain);
        }
        
        
    }
}
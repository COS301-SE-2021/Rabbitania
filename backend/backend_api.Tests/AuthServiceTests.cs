using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Exceptions.Auth;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using backend_api.Models.User;
using backend_api.Models.User.Responses;
using backend_api.Services.Auth;
using backend_api.Services.User;
using Moq;
using Xunit;
using Xunit.Abstractions;

namespace backend_api.Tests
{
    namespace backend_api.Tests
{
    public class AuthServiceTests
    {
        private readonly AuthService _authService;
        private readonly Mock<IUserRepository> _userRepositoryMock = new Mock<IUserRepository>();
        private readonly ITestOutputHelper outHelper;
        private readonly User _mockedUser;
        private readonly UserEmails _mockedEmail;
        private readonly UserService _userService;

        public AuthServiceTests(ITestOutputHelper outHelp)
        {
            _authService = new AuthService(_userRepositoryMock.Object);
            _userService = new UserService(_userRepositoryMock.Object);
            
            this.outHelper = outHelp;
            
            this._mockedUser = new User(
                50,
                "Unit Tests",
                "0834758854",
                new List<int>(){1},
                "www.google/test.png",
                "This is a Unit Test",
                true,
                1,
                UserRoles.Unassigned,
                OfficeLocation.Unassigned
            );
            this._mockedEmail = new UserEmails("test@tuks.co.za", 50);
        }
        
        [Fact(DisplayName = "Should be False if a non 'tuks.co.za' is used to login")]
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

        [Fact(DisplayName = "Should be true if a 'tuks.co.za' is used to login")]
        public void CorrectDomainLogin()
        {
            //Arrange
            string email = "test@tuks.co.za";
            GoogleSignInRequest request1 = new GoogleSignInRequest(email);
            
            //Act
            var response = _authService.CheckEmailDomain(request1);
            
            //Assert
            Assert.NotNull(response);
            Assert.IsType<DomainResponse>(response);
            Assert.Equal(true, response.CorrectDomain);
        }

        [Fact(DisplayName = "Should throw an exception for an invalid email in the database")]
        public async Task InvalidEmailLogin()
        {
            //Arrange
            var signInRequest = new GoogleSignInRequest(
                _mockedUser.Name, _mockedEmail.UserEmail, _mockedUser.PhoneNumber, _mockedUser.UserImgUrl
                );
            
            var request2 = new GoogleSignInRequest(
                "check",
                "check@tuks.co.za",
                "1234567899",
                "test.png");
           
            _userRepositoryMock.Setup(x => x.CreateUser(signInRequest));

            //Act
            var response = await _authService.checkEmailExists(request2);
            
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
            Assert.ThrowsAsync<NullEmailException>(() => _authService.checkEmailExists(request));
        }

        [Fact(DisplayName = "Should be true if the user already exists in the system")]
        public async Task CheckCorrectEmail()
        {
            //Arrange
            var requestDoa = new GoogleSignInRequest(_mockedUser.Name, _mockedEmail.UsersEmail, _mockedUser.PhoneNumber, _mockedUser.UserImgUrl);
            var responseDoa = new CreateUserResponse("User created.");

            _userRepositoryMock.Setup(u => u.CreateUser(requestDoa)).ReturnsAsync(responseDoa);
            
            //Act
            var response = await _authService.checkEmailExists(requestDoa);
            var resp = await _authService.GetUserName(_mockedUser.Name);
            
            //Assert
            Assert.NotNull(resp);
             //Assert.IsType<LoginResponse>(response);
             //Assert.True(response.EmailExists);
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
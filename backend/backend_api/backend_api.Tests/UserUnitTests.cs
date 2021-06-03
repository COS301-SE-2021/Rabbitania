using System;
using backend_api.Models;
using Xunit;

namespace backend_api.Tests
{
    public class UserUnitTests
    {
        private readonly User _sutUser;
        private readonly UserEmails _sutUserEmails;
        
        public UserUnitTests()
        {
            this._sutUser = new User();
            this._sutUserEmails = new UserEmails();
        }
        
        [Fact]
        public void createNewUserInstanceNotNull()
        {
            // given
            User newTestUser = new User();
            Assert.NotNull(newTestUser);
        }
        
        [Fact]
        public void createNewUserEmailInstanceNotNull()
        {
            UserEmails newTestUserEmails = new UserEmails();
            Assert.NotNull(newTestUserEmails);
        }
        
        [Fact]
        public void createNewUserEmailInstanceNotEmpty()
        {
            UserEmails newTestUserEmails = new UserEmails();
            //Assert.NotEmpty(newTestUserEmails);
        }

        [Fact]
        public void setUserEmail()
        {
            //this._sut.UserID = 1;
            //Assert.Equal(1, _sut.UserID);
        }
    }
}
using backend_api.Models;
using Xunit;

namespace backend_api.Tests
{
    public class UserTests
    {
        private readonly User _sut;

        public UserTests()
        {
            _sut = new User();
        }

        // [Fact]
        // public void VeryFirstTest()
        // {
        //     
        // }
        // [Fact]
        // public void createUser()
        // {
        //     User testUser = new User();
        //     Assert.NotNull(testUser);
        // }
        //
        // [Fact]
        // public void setUserID()
        // {
        //     this._sut.UserID = 1;
        //     Assert.Equal(1, _sut.UserID);
        // }
    }
}
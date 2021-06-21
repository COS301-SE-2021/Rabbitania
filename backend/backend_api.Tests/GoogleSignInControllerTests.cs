using System.Threading.Tasks;
using Xunit;

namespace backend_api.Tests
{
    public class GoogleSignInControllerTests: AuthIntegrationTests
    {
        [Fact(DisplayName = "Attempt to get ID with invalid email")]
        public async Task GetIDEndpoint_invalidEmail()
        {
            //Arrange
            
            //Act
            
            //Assert
        }
    }
}
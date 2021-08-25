using backend_api.Services.Chat;
using Xunit;

namespace backend_api.Tests.Chat
{
    public class ChatServiceIntegrationTests
    {
        private readonly ChatService _service;

        public ChatServiceIntegrationTests(ChatService service)
        {
            _service = service;
        }

        [Fact]
        public void EncryptAppID_NotFound()
        {
            //Arrange
            
            //Act
            
            //Assert
        }
    }
}
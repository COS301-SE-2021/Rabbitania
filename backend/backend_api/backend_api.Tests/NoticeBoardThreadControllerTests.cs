using System.Net;
using Xunit;

namespace backend_api.Tests
{
    public class NoticeBoardThreadControllerTests
    {
        [Fact]
        public async void getAllMethodTest()
        {
            var _client = new TestClientProvider()._client;

            var response = await _client.GetAsync("api/NoticeBoardThread");

            response.EnsureSuccessStatusCode();
            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        }

    }
}
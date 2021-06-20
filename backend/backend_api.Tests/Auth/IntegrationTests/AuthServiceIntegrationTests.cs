using System.Net.Http;
using System.Reflection;
using backend_api.Controllers.Auth;
using backend_api.Data.Notification;
using backend_api.Data.User;
using backend_api.Services.Auth;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Xunit;

namespace backend_api.Tests.Auth.IntegrationTests
{
    public class AuthServiceIntegrationTests
    {
        private HttpClient _client;

        public AuthServiceIntegrationTests()
        {
            // App factory
            // Using memory virtual Database
            var authFactory = new WebApplicationFactory<Startup>()
                .WithWebHostBuilder(builder =>
                {
                    builder.ConfigureServices(services =>
                    {
                        services.RemoveAll(typeof(UserContext));
                        services.AddDbContext<UserContext>(options =>
                        {
                            options.UseInMemoryDatabase("RabbitaniaDB");
                        });
                    });
                });
            _client = authFactory.CreateClient();
        }

        [Fact]
        public void GetUserID_ValidEmail()
        {
            DbContextOptionsBuilder<UserContext> optionsBuilder = new();
            optionsBuilder.UseInMemoryDatabase(MethodBase.GetCurrentMethod().Name);
            UserContext ctx = new(optionsBuilder.Options);
            
        }
    }
}
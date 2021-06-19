using System.Net.Http;
using backend_api.Data.Notification;
using backend_api.Data.User;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;

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
        
    }
}
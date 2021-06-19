using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using backend_api.Data.Notification;
using Microsoft.AspNetCore.Mvc.ApiExplorer;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Xunit;

namespace backend_api.Tests.NotificationTests.IntegrationTests
{
    public class NotificationIntegrationTests
    {
        private readonly HttpClient _notificationClient;
        
        public NotificationIntegrationTests()
        {
            // App factory
            // Using memory virtual Database
            var notificationFactory = new WebApplicationFactory<Startup>()
                .WithWebHostBuilder(builder =>
                {
                    builder.ConfigureServices(services =>
                    {
                        services.RemoveAll(typeof(NotificationContext));
                        services.AddDbContext<NotificationContext>(options =>
                        {
                            options.UseInMemoryDatabase("RabbitaniaDB");
                        });
                    });
                });
            _notificationClient = notificationFactory.CreateClient();
        }
        
        protected async Task Random()
        {
            return;
        }

        protected async Task<string> GetJwtAsync()
        {
            return "null";
        }
    }
}
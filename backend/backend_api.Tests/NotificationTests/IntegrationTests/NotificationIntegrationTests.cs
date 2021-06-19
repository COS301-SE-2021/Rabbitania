using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Threading.Tasks;
using backend_api.Data.Notification;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;

namespace backend_api.Tests.NotificationTests.IntegrationTests
{
    public class NotificationIntegrationTests
    {
        protected readonly HttpClient Http;

        protected NotificationIntegrationTests()
        {
            var notFactory = new WebApplicationFactory<Startup>()
                .WithWebHostBuilder(build =>
                {
                    build.ConfigureServices(services =>
                    {
                        services.RemoveAll(typeof(NotificationContext));
                        services.AddDbContext<NotificationContext>(opts =>
                        {
                            opts.UseInMemoryDatabase("RabbitaniaDB");
                        });
                    });
                });
            
            this.Http = notFactory.CreateClient();
        }
        
        
    }
}
using System;
using backend_api.Data.Node;
using backend_api.Data.User;
using backend_api.Services.Node;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace backend_api.Tests.Node.Integration
{
    public class NodeServiceTests
    {
        private readonly NodeService _service;
        private readonly INodeRepository _repository;
        private NodeContext _context;

        public NodeServiceTests()
        {
            var serviceProvider = new ServiceCollection().AddEntityFrameworkNpgsql().BuildServiceProvider();
            var builder = new DbContextOptionsBuilder<NodeContext>();
            var env = Environment.GetEnvironmentVariable("CONN_STRING");
            builder.UseNpgsql(env.ToString())
                .UseInternalServiceProvider(serviceProvider);
            
            _context = new NodeContext(builder.Options);
            

        }
    }
}
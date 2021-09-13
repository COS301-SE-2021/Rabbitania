using System;
using System.Net;
using backend_api.Data.Node;
using backend_api.Data.User;
using backend_api.Exceptions.Node;
using backend_api.Models.Node.Requests;
using backend_api.Services.Node;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Xunit;

namespace backend_api.Tests.Node.Integration
{
    public class NodeServiceTests
    {
        private readonly NodeService _service;
        private readonly INodeRepository _repository;
        private NodeContext _context;
        private UserContext _userContext;

        public NodeServiceTests()
        {
            var serviceProvider = new ServiceCollection().AddEntityFrameworkNpgsql().BuildServiceProvider();
            var builder = new DbContextOptionsBuilder<NodeContext>();
            var builderUser = new DbContextOptionsBuilder<UserContext>();
            
            var env = Environment.GetEnvironmentVariable("CONN_STRING");
            //Node Context builder
            builder.UseNpgsql(env.ToString())
                .UseInternalServiceProvider(serviceProvider);
            //User context builder
            builderUser.UseNpgsql(env.ToString())
                .UseInternalServiceProvider(serviceProvider);

            _userContext = new UserContext(builderUser.Options);
            _context = new NodeContext(builder.Options);
            _repository = new NodeRepository(_context, _userContext);
            _service = new NodeService(_repository);
        }

        [Fact]
        public async void getAllNodesTest()
        {
            //Arrange
            //Act
            var resp = await _service.GetAllNodes();
            //Assert
            Assert.NotNull(resp);
        }

        [Fact]
        public async void CreateNode_ValidNode()
        {
            //Arrange
            var request = new CreateNodeRequest("test@gmail.com", 100, 100, false);
            //Act
            var resp = await _service.CreateNode(request);
            //Assert
            Assert.Equal(HttpStatusCode.Created, resp.StatusCode);
        }

        [Fact]
        public async void CreateNode_InvalidNode_InvalidEmail()
        {
            //Arrange
            var request = new CreateNodeRequest("", 100, 100, false);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNodeException>(async () => await _service.CreateNode(request));
        }
        [Fact]
        public async void CreateNode_InvalidNode_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNodeException>(async () => await _service.CreateNode(null));
        }
        // [Fact]
        // public async void 
    }
}
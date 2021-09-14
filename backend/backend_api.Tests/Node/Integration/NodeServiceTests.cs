using System;
using System.Collections.Generic;
using System.Net;
using backend_api.Data.Node;
using backend_api.Data.User;
using backend_api.Exceptions.Node;
using backend_api.Models.Node.Requests;
using backend_api.Models.User.Requests;
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

        [Fact]
        public async void UpdateNode_ValidNode_Position()
        {
            //Arrange
            var request = new EditNodeRequest(1, 5, 5);
            //Act
            var resp = await _service.EditNode(request);
            //Assert
            Assert.Equal(HttpStatusCode.OK, resp.StatusCode);
        }

        [Fact]
        public async void UpdateNode_ValidNode_PositionAndActive()
        {
            //Arrange
            var request = new EditNodeRequest(1, 5, 5, true);
            //Act
            var resp = await _service.EditNode(request);
            //Assert
            Assert.Equal(HttpStatusCode.OK, resp.StatusCode);
            
        }
        [Fact]
        public async void UpdateNode_ValidNode_PositionAndActiveAndEmail()
        {
            //Arrange
            var request = new EditNodeRequest(1, 5, 5, "testest@gmail.com", true);
            //Act
            var resp = await _service.EditNode(request);
            //Assert
            Assert.Equal(HttpStatusCode.OK, resp.StatusCode);
        }

        [Fact]
        public async void UpdateNode_InvalidNode()
        {
            //Arrange
            var request = new EditNodeRequest(1000, 5, 5, "test@gmail.com", true);
            //Act
            var resp = await _service.EditNode(request);
            //Assert
            Assert.Equal(HttpStatusCode.BadRequest, resp.StatusCode);
        }

        [Fact]
        public async void UpdateNode_InvalidNode_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNodeException>(async () => await _service.EditNode(null));
        }

        [Fact]
        public async void DeleteNode_ValidNode()
        {
            //Arrange
            var addNode = new CreateNodeRequest("test@gmail.com", 100, 100, false);
            var request = new DeleteNodeRequest(5);
            //Act
            var respAdd = await _service.CreateNode(addNode);
            var resp = await _service.DeleteNode(request);
            //Assert
            Assert.Equal(HttpStatusCode.OK, resp.StatusCode);
        }

        [Fact]
        public async void DeleteNode_Invalid_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNodeException>(async () => await _service.DeleteNode(null));
        }

        [Fact]
        public async void DeleteNode_InvalidNodeID()
        {
            //Arrange
            var request = new DeleteNodeRequest(2000);
            //Act
            var resp = await _service.DeleteNode(request);
            //Assert
            Assert.Equal(HttpStatusCode.BadRequest, resp.StatusCode);
        }

        [Fact]
        public async void ActivateNode_ValidNode()
        {
            //Arrange
            var request = new ActivateNodeRequest("test@gmail.com");
            //Act
            var resp = await _service.ActivateNode(request);
            //Assert
            Assert.Equal(HttpStatusCode.OK, resp.StatusCode);
        }

        [Fact]
        public async void ActivateNode_InvalidNode()
        {
            //Arrange
            var request = new ActivateNodeRequest("");
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNodeException>(async ()=> await _service.ActivateNode(request));
        }

        [Fact]
        public async void GetNode_ValidNode()
        {
            //Arrange
            var request = new GetNodeRequest(1);
            //Act
            var resp = await _service.GetNode(request);
            //Assert
            Assert.Equal(1, resp.Node.Id);
        }
        [Fact]
        public async void GetNode_InvalidNode()
        {
            //Arrange
            var request = new GetNodeRequest(2000);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNodeException>(async ()=> await _service.GetNode(request));
        }

        [Fact]
        public async void GetNode_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNodeException>(async ()=> await _service.GetNode(null));
        }

        [Fact]
        public async void DeactivateAllNodes_ValidRequest()
        {
            //Arrange
            var request = new DeactivateAllNodesRequest();
            //Act
            var resp = await _service.DeactivateAllNodes(request);
            //Assert
            Assert.Equal(HttpStatusCode.OK, resp.StatusCode);
        }
        [Fact]
        public async void DeactivateAllNodes_InvalidRequest_Null()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNodeException>(async ()=> await _service.DeactivateAllNodes(null));
        }

        [Fact]
        public async void SaveNodes_InvalidRequest_EmptyNodeList()
        {
            //Arrange
            var list = new List<Models.Node.Node>();
            var request = new SaveNodesRequest(list);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNodeException>(async ()=> await _service.SaveNodes(request));
        }
        [Fact]
        public async void SaveNodes_InvalidRequest_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNodeException>(async ()=> await _service.SaveNodes(null));
        }
        [Fact]
        public async void SaveNodes_ValidRequest()
        {
            //Arrange
            var node1 = new Models.Node.Node("test@gmail.com", 40, 40, false);
            var node2 = new Models.Node.Node("testest@gmail.com", 50, 50, false);
            var node3 = new Models.Node.Node("test@gmail.com", 200, 50, false);
            var node4 = new Models.Node.Node("test@gmail.com", 50, 120, false);
            var list = new List<Models.Node.Node>();
            list.Add(node1);
            list.Add(node2);
            list.Add(node3);
            list.Add(node4);
            var request = new SaveNodesRequest(list);
            //Act
            var resp = await _service.SaveNodes(request);
            //Assert
            Assert.Equal(HttpStatusCode.OK, resp.StatusCode);
        }
    }
}
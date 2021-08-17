using System;
using System.Linq;
using System.Net;
using backend_api.Data.Forum;
using backend_api.Data.User;
using backend_api.Models.Forum;
using backend_api.Models.Forum.Requests;
using backend_api.Services.Forum;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

using Xunit;

namespace backend_api.Tests.Forum.Integration
{
    public class ForumServiceTest
    {
        private readonly Forums _mockForum;
        private readonly ForumContext _forumContext;
        private readonly UserContext _userContext;

        public ForumServiceTest()
        {
            var serviceProvider = new ServiceCollection().AddEntityFrameworkNpgsql().BuildServiceProvider();
            var builder = new DbContextOptionsBuilder<ForumContext>();
            var builder_user = new DbContextOptionsBuilder<UserContext>();
            
            builder.UseNpgsql("Server=localhost;Port=5432;Database=RabbitaniaTesting;Username=postgres;Password=1234")
                .UseInternalServiceProvider(serviceProvider);

            _forumContext = new ForumContext(builder.Options);
            _userContext = new UserContext(builder_user.Options);

            _mockForum = new Forums(
                "Forum Title",
                50,
                Convert.ToDateTime("2021-08-16 18:57:54.627600")
            );

          }
        [Fact(DisplayName = "Should return created HTTP response")]
        public async void CreateForumTest()
        {
            var forumRepo = new ForumRepository(_forumContext, _userContext);
            var req = new CreateForumRequest(_mockForum.ForumTitle, _mockForum.CreatedDate, _mockForum.UserId);
            var resp = forumRepo.CreateForum(req);
            
            Assert.Equal(HttpStatusCode.Created, resp.Result.Response);
        }

        [Fact(DisplayName = "Delete Forum Should return HTTP Status Code ACCEPTED")]
        public async void DeleteForum()
        {
            var forumRepo = new ForumRepository(_forumContext, _userContext);
            var forumService = new ForumService(forumRepo);
            var addReq = new CreateForumRequest(_mockForum.ForumTitle, _mockForum.CreatedDate, _mockForum.UserId);
            var resp = forumRepo.CreateForum(addReq);
            
            Assert.Equal(HttpStatusCode.Created, resp.Result.Response);

            var req = new RetrieveForumsRequest();
            var forums = await forumRepo.RetrieveForums(req);
            
            Assert.NotEmpty(forums);

            var deleteReq = new DeleteForumRequest(forums.Last().ForumId);
            var deleteResponse = forumService.DeleteForum(deleteReq);
            
            Assert.Equal(HttpStatusCode.Accepted, deleteResponse.Result.HttpStatusCode);
        }

        [Fact(DisplayName = "Edit Forum should return Http Status Code ACCEPTED")]
        public async void EditForum()
        {
            var forumRepo = new ForumRepository(_forumContext, _userContext);
            var forumService = new ForumService(forumRepo);
            
            var addReq = new CreateForumRequest(_mockForum.ForumTitle, _mockForum.CreatedDate, _mockForum.UserId);
            var resp = forumRepo.CreateForum(addReq);
            
            Assert.Equal(HttpStatusCode.Created, resp.Result.Response);

            var req = new RetrieveForumsRequest();
            var forums = await forumRepo.RetrieveForums(req);
            
            Assert.NotEmpty(forums);

            var editReq = new EditForumRequest(forums.Last().ForumId, forums.Last().ForumTitle);

            var editResponse = forumService.EditForum(editReq);
            
            Assert.Equal(HttpStatusCode.Accepted, editResponse.Result.Response);
        }
    }
}
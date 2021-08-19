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
        private readonly ForumThreads _mockForumThread;
        private readonly ThreadComments _mockThreadComment;
        private readonly ForumContext _forumContext;
        private readonly UserContext _userContext;

        public ForumServiceTest()
        {
            var serviceProvider = new ServiceCollection().AddEntityFrameworkNpgsql().BuildServiceProvider();
            var builder = new DbContextOptionsBuilder<ForumContext>();
            var builder_user = new DbContextOptionsBuilder<UserContext>();
            
            var env = Environment.GetEnvironmentVariable("CONN_STRING");
            builder.UseNpgsql(env)
                .UseInternalServiceProvider(serviceProvider);

            _forumContext = new ForumContext(builder.Options);
            _userContext = new UserContext(builder_user.Options);

            _mockForum = new Forums(
                "Forum Title",
                1,
                Convert.ToDateTime("2021-08-16 18:57:54.627600")
            );

            _mockForumThread = new ForumThreads(
                "Forum Thread Title",
                1,
                "Forum Thread Body",
                Convert.ToDateTime("2021-08-16 18:57:54.5265000"),
                "image.url",
                1
            );

            _mockThreadComment = new ThreadComments(
                "Thread Body",
                Convert.ToDateTime("2021-08-16 18:57:54.5265000"),
                "img.url",
                10,
                10,
                "Joseph",
                "img.url",
                1,
                1
            );

        }
        [Fact(DisplayName = "Create Forum should return created HTTP response")]
        public async void CreateForumTest()
        {
            var forumRepo = new ForumRepository(_forumContext, _userContext);
            var req = new CreateForumRequest(_mockForum.ForumTitle, _mockForum.CreatedDate, _mockForum.UserId);
            var resp = forumRepo.CreateForum(req);
            
            Assert.Equal(HttpStatusCode.Created, resp.Result.Response);
        }

        [Fact(DisplayName = "Delete Forum should return HTTP Status Code ACCEPTED")]
        public async void DeleteForum()
        {
            var forumRepo = new ForumRepository(_forumContext, _userContext);
            var forumService = new ForumService(forumRepo);
            var addReq = new CreateForumRequest(_mockForum.ForumTitle, _mockForum.CreatedDate, _mockForum.UserId);
            var resp = forumRepo.CreateForum(addReq);
            
            Assert.Equal(HttpStatusCode.Created, resp.Result.Response);

            var req = new RetrieveForumsRequest();
            var forums = await forumService.RetrieveForums(req);
            
            Assert.NotEmpty(forums.Forums);

            var deleteReq = new DeleteForumRequest(forums.Forums.Last().ForumId);
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
            var forums = await forumService.RetrieveForums(req);
            
            Assert.NotEmpty(forums.Forums);

            var editReq = new EditForumRequest(forums.Forums.Last().ForumId, forums.Forums.Last().ForumTitle);

            var editResponse = forumService.EditForum(editReq);
            
            Assert.Equal(HttpStatusCode.Accepted, editResponse.Result.Response);
        }

        [Fact(DisplayName = "Create Forum Thread should return HTTP status Code Created")]
        public async void CreateForumThread()
        {
            var forumRepo = new ForumRepository(_forumContext, _userContext);
            var forumService = new ForumService(forumRepo);
            
            var retrieveReq = new RetrieveForumsRequest();
            var forums = await forumService.RetrieveForums(retrieveReq);
            
            Assert.NotEmpty(forums.Forums);

            var forumId = forums.Forums.Last().ForumId;

            var req = new CreateForumThreadRequest(_mockForumThread.ForumThreadTitle, _mockForumThread.ForumThreadBody,
                _mockForumThread.CreatedDate, _mockForumThread.imageURL, _mockForumThread.UserId, forumId);

            var resp = forumService.CreateForumThread(req);
            
            Assert.Equal(HttpStatusCode.Created, resp.Result.Response);
        }


        [Fact(DisplayName = "Create Forum Thread with empty title should return HTTP status Code BadRequest")]
        public async void CreateForumThreadEmptyTitle()
        {
            var forumRepo = new ForumRepository(_forumContext, _userContext);
            var forumService = new ForumService(forumRepo);
            
            var retrieveReq = new RetrieveForumsRequest();
            var forums = await forumService.RetrieveForums(retrieveReq);
            
            Assert.NotEmpty(forums.Forums);

            var forumId = forums.Forums.Last().ForumId;

            var req = new CreateForumThreadRequest(null, _mockForumThread.ForumThreadBody,
                _mockForumThread.CreatedDate, _mockForumThread.imageURL, _mockForumThread.UserId, forumId);

            var resp = forumService.CreateForumThread(req);
            
            Assert.Equal(HttpStatusCode.BadRequest, resp.Result.Response);
        }

        [Fact(DisplayName = "Create Forum Thread with 0 user Id")]
        public async void CreateForumThreadInvalidUserId()
        {
            var forumRepo = new ForumRepository(_forumContext, _userContext);
            var forumService = new ForumService(forumRepo);

            var retrieveReq = new RetrieveForumsRequest();
            var forums = await forumService.RetrieveForums(retrieveReq);

            Assert.NotEmpty((forums.Forums));

            var forumId = forums.Forums.Last().ForumId;

            var req = new CreateForumThreadRequest(_mockForumThread.ForumThreadTitle, _mockForumThread.ForumThreadBody,
                _mockForumThread.CreatedDate, _mockForumThread.imageURL, 0, forumId);

            var resp = forumService.CreateForumThread(req);
            
            Assert.Equal(HttpStatusCode.BadRequest, resp.Result.Response);
        }

        [Fact(DisplayName = "Edit Forum Thread should return status code ACCEPTED")]
        public async void EditForumThread()
        {
            var forumRepo = new ForumRepository(_forumContext, _userContext);
            var forumService = new ForumService(forumRepo);
            var retrieveReq = new RetrieveForumsRequest();
            var forums = await forumService.RetrieveForums(retrieveReq);

            Assert.NotEmpty(forums.Forums);
            
            var forumId = forums.Forums.Last().ForumId;
            var createReq = new CreateForumThreadRequest(_mockForumThread.ForumThreadTitle, _mockForumThread.ForumThreadBody,
                _mockForumThread.CreatedDate, _mockForumThread.imageURL, _mockForumThread.UserId, forumId);
            var createResp = forumService.CreateForumThread(createReq);
            
            Assert.Equal(HttpStatusCode.Created, createResp.Result.Response);

            var retrieveThreadsReq = new RetrieveForumThreadsRequest(forumId);
            var threadsResp = forumService.RetrieveForumThreads(retrieveThreadsReq);
            
            Assert.NotEmpty(threadsResp.Result.ForumThreads);

            var req = new EditForumThreadRequest(threadsResp.Result.ForumThreads.Last().ForumThreadId, "Edit Test", "Edit Test", "img.url");
            var resp = forumService.EditForumThread(req);
            
            Assert.Equal(HttpStatusCode.Accepted, resp.Result.Response);
        }
        [Fact(DisplayName = "Delete Forum Thread should return status code ACCEPTED")]
        public async void DeleteForumThread()
        {
            var forumRepo = new ForumRepository(_forumContext, _userContext);
            var forumService = new ForumService(forumRepo);
            var retrieveReq = new RetrieveForumsRequest();
            var forums = await forumService.RetrieveForums(retrieveReq);

            Assert.NotEmpty(forums.Forums);
            
            var forumId = forums.Forums.Last().ForumId;
            var createReq = new CreateForumThreadRequest(_mockForumThread.ForumThreadTitle, _mockForumThread.ForumThreadBody,
                _mockForumThread.CreatedDate, _mockForumThread.imageURL, _mockForumThread.UserId, forumId);
            var createResp = forumService.CreateForumThread(createReq);
            
            Assert.Equal(HttpStatusCode.Created, createResp.Result.Response);

            var retrieveThreadsReq = new RetrieveForumThreadsRequest(forumId);
            var threadsResp = forumService.RetrieveForumThreads(retrieveThreadsReq);
            
            Assert.NotEmpty(threadsResp.Result.ForumThreads);

            var req = new DeleteForumThreadRequest(threadsResp.Result.ForumThreads.Last().ForumThreadId);
            var resp = forumService.DeleteForumThread(req);
            
            Assert.Equal(HttpStatusCode.Accepted, resp.Result.HttpStatusCode);
        }


        
        
        
    }
}
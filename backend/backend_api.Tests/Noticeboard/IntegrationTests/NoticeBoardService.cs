using System;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.NoticeBoard;
using backend_api.Data.Notification;
using backend_api.Data.User;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Exceptions.Notifications;
using backend_api.Models.Enumerations;
using backend_api.Models.Forum.Responses;
using backend_api.Models.NoticeBoard;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;
using backend_api.Services.NoticeBoard;
using backend_api.Services.Notification;
using backend_api.Services.User;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Xunit;
using Xunit.Abstractions;

namespace backend_api.Tests.Noticeboard.IntegrationTests
{
    public class NoticeboardService
    {
        private NoticeBoardContext _noticeboardContext;
        private readonly INoticeBoardService _service;
        private readonly INoticeBoardRepository _repository;
        private readonly IUserService _userService;
        private UserContext _userContext;
        private readonly IUserRepository _userRepository;
        private readonly INotificationService _notificationService;
        private readonly INotificationRepository _notificationRepository;
        private NotificationContext _notificationContext;
        
        public NoticeboardService()
        {
            var serviceProvider = new ServiceCollection().AddEntityFrameworkNpgsql().BuildServiceProvider();
            var builder = new DbContextOptionsBuilder<NoticeBoardContext>();
            var userBuilder = new DbContextOptionsBuilder<UserContext>();
            var notificationBuilder = new DbContextOptionsBuilder<NotificationContext>();
            var env = Environment.GetEnvironmentVariable("CONN_STRING");
            
            //NoticeBoard Context builder
            builder.UseNpgsql(env.ToString())
                .UseInternalServiceProvider(serviceProvider);
            //User context builder
            userBuilder.UseNpgsql(env.ToString())
                .UseInternalServiceProvider(serviceProvider);
            //Notification context builder
            notificationBuilder.UseNpgsql(env.ToString())
                .UseInternalServiceProvider(serviceProvider);

            //User
            _userContext = new UserContext(userBuilder.Options);
            _userRepository = new UserRepository(_userContext);
            _userService = new UserService(_userRepository);

            //Notification
            _notificationContext = new NotificationContext(notificationBuilder.Options);
            _notificationRepository = new NotificationRepository(_notificationContext);
            _notificationService = new NotificationService(_notificationRepository);
            
            //Noticeboard
            _noticeboardContext = new NoticeBoardContext(builder.Options);
            _repository = new NoticeBoardRepository(_noticeboardContext);
            _service = new NoticeBoardService(_repository, _userService, _notificationService);
        }
        private async Task addMockedThread()
        {
            var noticeThread = new Models.NoticeBoard.NoticeBoard();
            noticeThread.Icon1 = 0;
            noticeThread.Icon2 = 0;
            noticeThread.Icon3 = 0;
            noticeThread.Icon4 = 0;
            noticeThread.ImageUrl = "test.png";
            noticeThread.ThreadContent = "Mock";
            noticeThread.ThreadTitle = "To Delete";
            noticeThread.UserId = 1;
            noticeThread.MinEmployeeLevel = 0;
            noticeThread.PermittedUserRoles = UserRoles.Designer;
            noticeThread.ThreadId = 500;
            
            await _noticeboardContext.NoticeBoard.AddAsync(noticeThread);
            await _noticeboardContext.SaveChangesAsync();
        }

        [Fact]
        public async void AddNoticeBoardThread_InvalidThread_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(async () =>
                await _service.AddNoticeBoardThread(null));
        }

        [Fact]
        public async void AddNoticeBoardThread_InvalidThread_InvalidTitle()
        {
            //Arrange
            var request =
                new AddNoticeBoardThreadRequest(0, "", "Test", 0, "image.png", UserRoles.Designer, 0, 1, 1, 1, 1);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidThreadTitleException>(async () =>
                await _service.AddNoticeBoardThread(request));
        }
        [Fact]
        public async void AddNoticeBoardThread_InvalidThread_InvalidContent()
        {
            //Arrange
            var request =
                new AddNoticeBoardThreadRequest(0, "Test", "", 0, "image.png", UserRoles.Designer, 0, 1, 1, 1, 1);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidThreadContentException>(async () =>
                await _service.AddNoticeBoardThread(request));
        }
        [Fact]
        public async void AddNoticeBoardThread_InvalidThread_InvalidUser()
        {
            //Arrange
            var request =
                new AddNoticeBoardThreadRequest(0, "Test", "Test", 0, "image.png", UserRoles.Designer, 0, 1, 1, 1, 1);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidUserIdException>(async () =>
                await _service.AddNoticeBoardThread(request));
        }
        [Fact]
        public async void AddNoticeBoardThread_ValidThread()
        {
            //Arrange
            var request =
                new AddNoticeBoardThreadRequest(1, "Test", "Test", 0, "image.png", UserRoles.Designer, 1, 1, 1, 1, 1);
            //Act
            var resp = await _service.AddNoticeBoardThread(request);
            //Assert
            Assert.Equal(HttpStatusCode.Created, resp.Response);
        }

        [Fact]
        public async void RetrieveNoticeBoardThreads_InvalidRequest_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(async () =>
                await _service.RetrieveNoticeBoardThreads(null));
        }

        [Fact]
        public async void RetrieveNoticeBoardThreads_ValidRequest()
        {
            //Arrange
            var request = new RetrieveNoticeBoardThreadsRequest();
            //Act
            var resp = await _service.RetrieveNoticeBoardThreads(request);
            //Assert
            Assert.NotEmpty(resp.NoticeBoard);
        }

        [Fact]
        public async void DeleteNoticeBoardThread_InvalidRequest_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(async () =>
                await _service.DeleteNoticeBoardThread(null));
        }
        [Fact]
        public async void DeleteNoticeBoardThread_InvalidRequest_InvalidThreadIDNegative()
        {
            //Arrange
            var request = new DeleteNoticeBoardThreadRequest(-1);
            //Act
            
            //Assert
            await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(async () =>
                await _service.DeleteNoticeBoardThread(request));
        }

        [Fact]
        public async void DeleteNoticeBoardThread_ValidRequest()
        {
            //Arrange
            await addMockedThread();
            var request = new DeleteNoticeBoardThreadRequest(500);
            //Act
            var resp = await _service.DeleteNoticeBoardThread(request);
            //Assert
            Assert.Equal(HttpStatusCode.Accepted, resp.HttpStatusCode);
        }
        [Fact]
        public async void DeleteNoticeBoardThread_InvalidRequest_InvalidThreadIDPositive()
        {
            //Arrange
            var request = new DeleteNoticeBoardThreadRequest(100000);
            //Act
            var resp = await _service.DeleteNoticeBoardThread(request);
            //Assert
            Assert.Equal(HttpStatusCode.BadRequest, resp.HttpStatusCode);
        }

        [Fact]
        public async void EditNoticeBoard_InvalidRequest_NullRequest()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(async () =>
                await _service.EditNoticeBoardThread(null));
        }
        [Fact]
        public async void EditNoticeBoard_InvalidRequest_IDZero()
        {
            //Arrange
            var request = new EditNoticeBoardThreadRequest(0, "Test", "Test", 0, "edited.png", UserRoles.Director, 1, 2,
                2, 2, 2);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(async () =>
                await _service.EditNoticeBoardThread(request));
        }
        [Fact]
        public async void EditNoticeBoard_ValidRequest()
        {
            //Arrange
            var request = new EditNoticeBoardThreadRequest(1, "Test", "Test", 0, "edited.png", UserRoles.Director, 1, 2,
                2, 2, 2);
            //Act
            var resp = await _service.EditNoticeBoardThread(request);
            //Assert
            Assert.Equal(HttpStatusCode.Accepted, resp.Response);
        }
        [Fact]
        public async void EditNoticeBoard_ValidRequest_InvalidThread()
        {
            //Arrange
            var request = new EditNoticeBoardThreadRequest(99999, "Test", "Test", 0, "edited.png", UserRoles.Director, 1, 2,
                2, 2, 2);
            //Act
            var resp = await _service.EditNoticeBoardThread(request);
            //Assert
            Assert.Equal(HttpStatusCode.BadRequest, resp.Response);

        }
        [Fact]
        public async void DecreaseEmoji_InvalidRequest_Null()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(async () =>
                await _service.DecreaseEmoji(null));
        }
        [Fact]
        public async void DecreaseEmoji_InvalidRequest_IDZero()
        {
            //Arrange
            var request = new DecreaseEmojiRequest("emoji",0);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(async () =>
                await _service.DecreaseEmoji(request));
        }
        [Fact]
        public async void DecreaseEmoji_InvalidRequest_IDNegative()
        {
            //Arrange
            var request = new DecreaseEmojiRequest("emoji",-1);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(async () =>
                await _service.DecreaseEmoji(request));
        }
        [Fact]
        public async void IncreaseEmoji_InvalidRequest_IDNegative()
        {
            //Arrange
            var request = new IncreaseEmojiRequest("emoji",-1);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(async () =>
                await _service.IncreaseEmoji(request));
        }
        [Fact]
        public async void IncreaseEmoji_InvalidRequest_IDZero()
        {
            //Arrange
            var request = new IncreaseEmojiRequest("emoji",0);
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(async () =>
                await _service.IncreaseEmoji(request));
        }
        [Fact]
        public async void IncreaseEmoji_InvalidRequest_Null()
        {
            //Arrange
            //Act
            //Assert
            await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(async () =>
                await _service.IncreaseEmoji(null));
        }
        [Fact]
        public async void IncreaseEmoji_ValidRequest()
        {
            //Arrange
            var request = new IncreaseEmojiRequest("IconData(U+F0230)",1);
            //Act
            var resp = await _service.IncreaseEmoji(request);
            //Assert
            Assert.Equal(HttpStatusCode.OK, resp.Response);
        }
        [Fact]
        public async void DecreaseEmoji_ValidRequest()
        {
            //Arrange
            var request = new DecreaseEmojiRequest("IconData(U+F0230)",1);
            //Act
            var resp = await _service.DecreaseEmoji(request);
            //Assert
            Assert.Equal(HttpStatusCode.OK, resp.Response);
        }
    }
}
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.NoticeBoard;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Models.Enumerations;
using backend_api.Models.NoticeBoard;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;
using backend_api.Services.NoticeBoard;
using Moq;
using Xunit;
using Xunit.Abstractions;

namespace backend_api.Tests.Noticeboard.UnitTests
{
    public class DeleteNoticeBoardThreadTests
    {
        private readonly ITestOutputHelper _testOutputHelper;
        private readonly NoticeBoardService _sut;
        private readonly Mock<INoticeBoardRepository> _noticeBoardRepoMock = new Mock<INoticeBoardRepository>();
        private readonly List<NoticeBoard> _mockedListDto;
        
        public DeleteNoticeBoardThreadTests()
        {
            _sut = new NoticeBoardService(_noticeBoardRepoMock.Object);
            _mockedListDto = new List<NoticeBoard>()
            {
                new NoticeBoard
                {
                    ThreadId = 1,
                    ThreadTitle = "List Item Title 1",
                    ThreadContent = "List Item Content 1",
                    MinEmployeeLevel = 1,
                    ImageUrl = "image.png",
                    PermittedUserRoles = UserRoles.Administrator,
                    UserId = 1
                },
                new NoticeBoard
                {
                    ThreadId = 2,
                    ThreadTitle = "List Item Title 2",
                    ThreadContent = "List Item Content 2",
                    MinEmployeeLevel = 1,
                    ImageUrl = "image.png",
                    PermittedUserRoles = UserRoles.Administrator,
                    UserId = 1
                },
                new NoticeBoard
                {
                    ThreadId = 3,
                    ThreadTitle = "List Item Title 3",
                    ThreadContent = "List Item Content 3",
                    MinEmployeeLevel = 1,
                    ImageUrl = "image.png",
                    PermittedUserRoles = UserRoles.Administrator,
                    UserId = 1
                }
            };
        }

        [Fact(DisplayName = "When The DeleteNoticeBoardThreadRequest is null, an exception should be thrown")]
        public async Task DeleteNoticeBoardThreads_ThrowInvalidNoticeBoardThreadRequestOnNullObject()
        {
            var exception =
                await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(() => _sut.DeleteNoticeBoardThread(null));
            Assert.Equal("Invalid DeleteNoticeBoardThreadRequest Object", exception.Message);
        }

        [Fact(DisplayName = "When a request to delete a Noticeboard thread is passed in, a thread should be deleted")]
        public async Task DeleteNoticeBoardThread_SuccessfullyDeleteThread()
        {
            var requestDto = new DeleteNoticeBoardThreadRequest(
                1
            );

            var responseDto = new DeleteNoticeBoardThreadResponse(HttpStatusCode.Accepted);
            
            _noticeBoardRepoMock.Setup(nb => nb.DeleteNoticeBoardThread(requestDto)).ReturnsAsync(responseDto);

            var noticeBoard = await _sut.DeleteNoticeBoardThread(requestDto);

            Assert.Equal(HttpStatusCode.Accepted, noticeBoard.HttpStatusCode);
        }

        [Fact(DisplayName = "When a threadId is zero or null, throw an invalidNoticeBoardThreadRequest")]
        public async Task DeleteNoticeBoardThread_InvalidThreadID()
        {
            var requestDto = new DeleteNoticeBoardThreadRequest(
                0
            );

            var exception =
                await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(() =>
                    _sut.DeleteNoticeBoardThread(requestDto));
            
            Assert.Equal("Invalid ThreadId", exception.Message);

        }
        
    }
}
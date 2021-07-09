using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Data.NoticeBoard;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Models.NoticeBoard;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;
using backend_api.Models.User;
using backend_api.Services.NoticeBoard;
using Moq;
using Xunit;

namespace backend_api.Tests
{
    public class RetrieveNoticeBoardThreadTests
    {
        private readonly NoticeBoardService _sut;
        private readonly Mock<INoticeBoardRepository> _noticeBoardRepoMock = new Mock <INoticeBoardRepository>();
        private readonly List<NoticeBoard> _mockedListDto;

        public RetrieveNoticeBoardThreadTests()
        {
            _sut = new NoticeBoardService(_noticeBoardRepoMock.Object);
            _mockedListDto = new List<NoticeBoard>()
            {
                new NoticeBoard
                {
                    ThreadTitle = "Welcome back Rabbits!",
                    ThreadContent = "This is going to be a great year",
                    MinEmployeeLevel = 1,
                    ImageUrl = "image.png",
                    PermittedUserRoles = UserRoles.Administrator,
                    UserId = 1
                },
                new NoticeBoard
                {
                    ThreadTitle = "Unfortunately Our offices are going to have to close temporarily due to Covid",
                    ThreadContent = "We will make it through this year",
                    MinEmployeeLevel = 1,
                    ImageUrl = "image.png",
                    PermittedUserRoles = UserRoles.Administrator,
                    UserId = 1
                },
                new NoticeBoard
                {
                    ThreadTitle = "There is a company event happening next week Monday",
                    ThreadContent = "Hope to see you all there!",
                    MinEmployeeLevel = 1,
                    ImageUrl = "image.png",
                    PermittedUserRoles = UserRoles.Administrator,
                    UserId = 1
                }
            };
        }

        [Fact(DisplayName = "When the RetrieveNoticeBoardThreadsRequest is null, an exception should be thrown")]
        public async Task RetrieveNoticeBoardThreads_ThrowInvalidNoticeBoardThreadRequestOnNullObject()
        {
            var exception =
                await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(
                    () => _sut.RetrieveNoticeBoardThreads(null));
            Assert.Equal("Invalid RetrieveNoticeBoardThreadsRequest object", exception.Message);
        }

        [Fact(DisplayName =
            "When a request to retrieve all Notice Board threads is passed in a list of Noticeboard Threads should be returned")]
        public async Task RetrieveNoticeBoardThreads_ReturnListOfNoticeBoardThreads()
        {
            var requestDto = new RetrieveNoticeBoardThreadsRequest();
            var responseDto = new RetrieveNoticeBoardThreadsResponse(_mockedListDto);
            _noticeBoardRepoMock.Setup(n => n.RetrieveAllNoticeBoardThreads(requestDto)).ReturnsAsync(_mockedListDto);
            var noticeBoardThreadList = await _sut.RetrieveNoticeBoardThreads(requestDto);
            Assert.Equal(responseDto.NoticeBoard, noticeBoardThreadList.NoticeBoard);
        }
        
        
        
        
    }
}
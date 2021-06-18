using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Data.NoticeBoard;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Models.NoticeBoard;
using backend_api.Models.User;
using backend_api.Services.NoticeBoard;
using Moq;
using Xunit;

namespace backend_api.Tests.NoticeBoardTests.UnitTests
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
                    MinLevel = 1,
                    ImageUrl = "image.png",
                    PermittedUserRoles = UserRoles.Administrator,
                    UserId = 1
                },
                new NoticeBoard
                {
                    ThreadTitle = "Unfortunately Our offices are going to have to close temporarily due to Covid",
                    ThreadContent = "We will make it through this year",
                    MinLevel = 1,
                    ImageUrl = "image.png",
                    PermittedUserRoles = UserRoles.Administrator,
                    UserId = 1
                },
                new NoticeBoard
                {
                    ThreadTitle = "There is a company event happening next week Monday",
                    ThreadContent = "Hope to see you all there!",
                    MinLevel = 1,
                    ImageUrl = "image.png",
                    PermittedUserRoles = UserRoles.Administrator,
                    UserId = 1
                }
            };
        }

        [Fact(DisplayName = "When the RetrieveNoticeBoardThreadsRequest is null, an exception should be thrown")]
        public async Task RetrieveNoticeBoardThreads_ThrowInvalidNoticeBoardThreadRequestOnInvalidRequest()
        {
            
        }
    }
}
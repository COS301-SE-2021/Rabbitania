﻿using System.Net;
using System.Threading.Tasks;
using backend_api.Data.NoticeBoard;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Exceptions.Notifications;
using backend_api.Models.Enumerations;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;
using backend_api.Models.User;
using backend_api.Services.NoticeBoard;
using Moq;
using Xunit;

namespace backend_api.Tests
{
    public class CreateNoticeBoardThreadTests
    {
        private readonly NoticeBoardService _sut;
        private readonly Mock<INoticeBoardRepository> _noticeBoardRepoMock = new Mock<INoticeBoardRepository>();

        public CreateNoticeBoardThreadTests()
        {
            _sut = new NoticeBoardService(_noticeBoardRepoMock.Object);
        }

        [Fact(DisplayName =
            "When a request object is null, the noticeboard thread should not be created and throw an InvalidNoticeBoardRequestException")]
        public async Task CreateNoticeBoardThread_ExceptionOnNullObject()
        {
            var exception = await Assert.ThrowsAsync<InvalidNoticeBoardRequestException>(() => _sut.AddNoticeBoardThread(null));
            Assert.Equal("Invalid AddNoticeBoardRequest object", exception.Message);
        }

        [Fact(DisplayName =
            "When Thread Title is empty, AddNoticeBoardThread should throw an InvalidThreadTitleException")]
        public async Task AddNoticeBoardThread_ExceptionOnEmptyThreadTitle()
        {
            var requestDto = new AddNoticeBoardThreadRequest(
            "",
            "thread content",
            1,
            "image.png",
            UserRoles.Administrator,
            1
                );
            var exception = await Assert.ThrowsAsync<InvalidThreadTitleException>(() => _sut.AddNoticeBoardThread(requestDto));
            
            Assert.Equal("The thread title cannot be null or empty", exception.Message);
        }
        
        [Fact(DisplayName =
            "When Thread Title is null, AddNoticeBoardThread should throw an InvalidThreadTitleException")]
        public async Task AddNoticeBoardThread_ExceptionOnNullThreadTitle()
        {
            var requestDto = new AddNoticeBoardThreadRequest(
                null,
                "thread content",
                1,
                "image.png",
                UserRoles.Administrator,
                1
            );
            var exception = await Assert.ThrowsAsync<InvalidThreadTitleException>(() => _sut.AddNoticeBoardThread(requestDto));
            
            Assert.Equal("The thread title cannot be null or empty", exception.Message);
        }

        
        [Fact(DisplayName =
            "When Thread Content is Empty, AddNoticeBoardThread should throw an InvalidThreadContentException")]
        public async Task AddNoticeBoardThread_ExceptionOnEmptyThreadContent()
        {
            var requestDto = new AddNoticeBoardThreadRequest(
                "Thread Title",
                "",
                2,
                "image.png",
                UserRoles.Administrator,
                1
            );
            var exception = await Assert.ThrowsAsync<InvalidThreadContentException>(() => _sut.AddNoticeBoardThread(requestDto));
            
            Assert.Equal("The thread content cannot be null or empty", exception.Message);
        }
        
        [Fact(DisplayName =
            "When Thread Content is null, AddNoticeBoardThread should throw an InvalidThreadContentException")]
        public async Task AddNoticeBoardThread_ExceptionOnNullThreadContent()
        {
            var requestDto = new AddNoticeBoardThreadRequest(
                "Thread Title",
                null,
                1,
                "image.png",
                UserRoles.Administrator,
                1
            );
            var exception = await Assert.ThrowsAsync<InvalidThreadContentException>(() => _sut.AddNoticeBoardThread(requestDto));
            
            Assert.Equal("The thread content cannot be null or empty", exception.Message);
        }
      
        

        [Fact(DisplayName = "When a userId is invalid (<= 0), an InvalidUserIdException should be thrown")]
        public async Task AddNoticeBoardThread_ExceptionOnInvalidUserID()
        {
            var requestDto = new AddNoticeBoardThreadRequest(
            "Thread Title",
            "Thread Content",
            1,
            "image.png",
            UserRoles.Administrator,
            -1
                );

            var exception =
                await Assert.ThrowsAsync<InvalidUserIdException>(() => _sut.AddNoticeBoardThread(requestDto));
            
            Assert.Equal("UserID is invalid", exception.Message);
        }
    }
}
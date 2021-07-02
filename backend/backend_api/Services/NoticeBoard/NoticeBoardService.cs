using System;
using System.Threading.Tasks;
using backend_api.Data.NoticeBoard;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Exceptions.Notifications;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;
using Castle.Core.Internal;
using Xunit.Sdk;

namespace backend_api.Services.NoticeBoard
{
    public class NoticeBoardService : INoticeBoardService
    {
        private readonly INoticeBoardRepository _noticeBoardRepository;
        public NoticeBoardService(INoticeBoardRepository noticeBoardRepo)
        {
            _noticeBoardRepository = noticeBoardRepo;
        }
        
        /// <inheritdoc />
        public async Task<AddNoticeBoardThreadResponse> AddNoticeBoardThread(AddNoticeBoardThreadRequest request)
        {
            if (request == null)
            {
                throw new InvalidNoticeBoardRequestException("Invalid AddNoticeBoardRequest object");
            }

            if (request.ThreadTitle.IsNullOrEmpty())
            {
                throw new InvalidThreadTitleException("The thread title cannot be null or empty");
            }

            if (request.ThreadContent.IsNullOrEmpty())
            {
                throw new InvalidThreadContentException("The thread content cannot be null or empty");
            }

            if (request.UserId <= 0)
            {
                throw new InvalidUserIdException("UserID is invalid");
            }
            return await _noticeBoardRepository.AddNoticeBoardThread(request);
        }

        /// <inheritdoc />
        public async Task<RetrieveNoticeBoardThreadsResponse> RetrieveNoticeBoardThreads(
            RetrieveNoticeBoardThreadsRequest request)
        {
            RetrieveNoticeBoardThreadsResponse response = new RetrieveNoticeBoardThreadsResponse(
                await _noticeBoardRepository.RetrieveAllNoticeBoardThreads(request));

            if (request == null)
            {
                throw new InvalidNoticeBoardRequestException("Invalid RetrieveNoticeBoardThreadsRequest object");
            }

            return response;
        }

        /// <inheritdoc />
        public async Task<DeleteNoticeBoardThreadResponse> DeleteNoticeBoardThread(
            DeleteNoticeBoardThreadRequest request)
        {
            if (request == null)
            {
                throw new InvalidNoticeBoardRequestException("Invalid DeleteNoticeBoardThreadRequest Object");
            }

            if (request.ThreadId == 0)
            {
                throw new InvalidNoticeBoardRequestException("Invalid ThreadId");
            }

            return await _noticeBoardRepository.DeleteNoticeBoardThread(request);
        }
    }
}
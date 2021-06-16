using System;
using System.Threading.Tasks;
using backend_api.Data.NoticeBoard;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;
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
        public async Task<AddNoticeBoardThreadResponse> AddNoticeBoardThread(AddNoticeBoardThreadRequest request)
        {
            return await _noticeBoardRepository.AddNoticeBoardThread(request);
        }

        public async Task<RetrieveNoticeBoardThreadsResponse> RetrieveNoticeBoardThreads(
            RetrieveNoticeBoardThreadsRequest request)
        {
            RetrieveNoticeBoardThreadsResponse response = new RetrieveNoticeBoardThreadsResponse(
                await _noticeBoardRepository.RetrieveAllNoticeBoardThreads(request)
            );

            if (response == null)
            {
                throw new InvalidNoticeBoardRequestException("There are no Noticeboard Threads to retrieve");
            }

            return response;
        }
    }
}
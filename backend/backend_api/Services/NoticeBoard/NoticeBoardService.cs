using System;
using System.Threading.Tasks;
using backend_api.Data.NoticeBoard;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;

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
    }
}
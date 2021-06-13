using System;

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
        public AddNoticeBoardThreadResponse AddNoticeBoardThread(AddNoticeBoardThreadRequest request)
        {
            if (request.ThreadId == null)
            {
                throw new Exception("ThreadID Missing");
            }

            return _noticeBoardRepository.AddNoticeBoardThread(request);
        }
    }
}
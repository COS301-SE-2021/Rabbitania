using System.Collections.Generic;

namespace backend_api.Models.NoticeBoard.Responses
{
    public class RetrieveNoticeBoardThreadsResponse
    {
        private IEnumerable<NoticeBoard> _noticeBoard;
        
        public RetrieveNoticeBoardThreadsResponse(IEnumerable<NoticeBoard> threads)
        {
            this._noticeBoard = threads;
        }
        
        public IEnumerable<NoticeBoard> NoticeBoard
        {
            get => _noticeBoard;
            set => _noticeBoard = value;
        }

    }
}
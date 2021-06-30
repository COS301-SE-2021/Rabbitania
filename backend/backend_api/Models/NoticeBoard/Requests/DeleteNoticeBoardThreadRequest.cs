namespace backend_api.Models.NoticeBoard.Requests
{
    public class DeleteNoticeBoardThreadRequest
    {
        public DeleteNoticeBoardThreadRequest()
        {
            
        }

        public DeleteNoticeBoardThreadRequest(int threadId)
        {
            _threadId = threadId;
        }

        private int _threadId;

        public int ThreadId
        {
            get => _threadId;
            set => _threadId = value;
        }
    }
}
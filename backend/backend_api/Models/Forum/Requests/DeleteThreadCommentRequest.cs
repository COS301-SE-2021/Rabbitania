namespace backend_api.Models.Forum.Requests
{
    public class DeleteThreadCommentRequest
    {
        private int _threadCommentId;

        public DeleteThreadCommentRequest()
        {
            
        }

        public DeleteThreadCommentRequest(int threadCommentId)
        {
            _threadCommentId = threadCommentId;
        }

        public int ThreadCommentId
        {
            get => _threadCommentId;
            set => _threadCommentId = value;
        }
    }
}
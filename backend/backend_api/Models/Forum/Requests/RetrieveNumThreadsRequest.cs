namespace backend_api.Models.Forum.Requests
{
    public class RetrieveNumThreadsRequest
    {
        private int _forumId;

        public RetrieveNumThreadsRequest()
        {
            
        }

        public RetrieveNumThreadsRequest(int forumId)
        {
            _forumId = forumId;
        }

        public int ForumId
        {
            get => _forumId;
            set => _forumId = value;
        }
    }
}
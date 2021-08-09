namespace backend_api.Models.Forum.Requests
{
    public class RetrieveForumThreadsRequest
    {
        private int _forumId;
        public RetrieveForumThreadsRequest()
        {
            
        }

        public RetrieveForumThreadsRequest(int forumId)
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
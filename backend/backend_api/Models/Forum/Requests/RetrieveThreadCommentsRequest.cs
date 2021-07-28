namespace backend_api.Models.Forum.Requests
{
    public class RetrieveThreadCommentsRequest
    {
        private int _forumThreadId;
        
        public RetrieveThreadCommentsRequest(int forumThreadId)
        {
            _forumThreadId = forumThreadId;
        }

        public RetrieveThreadCommentsRequest()
        {
            
        }
        
        public int ForumThreadId
        {
            get => _forumThreadId;
            set => _forumThreadId = value;
        }

    }
}
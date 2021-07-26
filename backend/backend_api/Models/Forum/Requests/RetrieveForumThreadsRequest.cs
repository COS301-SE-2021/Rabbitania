namespace backend_api.Models.Forum.Requests
{
    public class RetrieveForumThreadsRequest
    {
        private int forumId;
        public RetrieveForumThreadsRequest()
        {
            
        }

        public RetrieveForumThreadsRequest(int forumId)
        {
            this.forumId = forumId;
        }

        public int ForumId
        {
            get => forumId;
            set => forumId = value;
        }
    }
}
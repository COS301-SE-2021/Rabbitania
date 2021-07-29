namespace backend_api.Models.Forum.Requests
{
    public class DeleteForumThreadRequest
    {
        private int _forumThreadId;

        public DeleteForumThreadRequest()
        {
            
        }

        public DeleteForumThreadRequest(int forumThreadId)
        {
            _forumThreadId = forumThreadId;
        }

        public int ForumThreadId
        {
            get => _forumThreadId;
            set => _forumThreadId = value;
        }
    }
}
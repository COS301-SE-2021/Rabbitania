namespace backend_api.Models.Forum.Requests
{
    public class EditForumRequest
    {
        
        private int _forumId;
        private int _forumTitle;
        
        public EditForumRequest()
        {
        }

        public EditForumRequest(int forumId, int forumTitle)
        {
            _forumId = forumId;
            _forumTitle = forumTitle;
        }

        public int ForumId
        {
            get => _forumId;
            set => _forumId = value;
        }

        public int ForumTitle
        {
            get => _forumTitle;
            set => _forumTitle = value;
        }

        
    }
}
namespace backend_api.Models.Forum.Requests
{
    public class EditForumRequest
    {
        
        private int _forumId;
        private string _forumTitle;
        
        public EditForumRequest()
        {
        }

        public EditForumRequest(int forumId, string forumTitle)
        {
            _forumId = forumId;
            _forumTitle = forumTitle;
        }

        public int ForumId
        {
            get => _forumId;
            set => _forumId = value;
        }

        public string ForumTitle
        {
            get => _forumTitle;
            set => _forumTitle = value;
        }

        
    }
}
namespace backend_api.Models.Forum.Requests
{
    public class EditForumThreadRequest
    {
        public EditForumThreadRequest()
        {
        }

        private int _forumThreadId;
        private string _forumThreadTitle;
        private string _forumThreadBody;
        private string _imageUrl;
        public string ForumThreadBody
        {
            get => _forumThreadBody;
            set => _forumThreadBody = value;
        }

        public int ForumThreadId
        {
            get => _forumThreadId;
            set => _forumThreadId = value;
        }

        public string ForumThreadTitle
        {
            get => _forumThreadTitle;
            set => _forumThreadTitle = value;
        }

        public string ImageUrl
        {
            get => _imageUrl;
            set => _imageUrl = value;
        }

        public EditForumThreadRequest(int forumThreadId, string forumThreadTitle, string forumThreadBody, string imageUrl)
        {
            _forumThreadId = forumThreadId;
            _forumThreadTitle = forumThreadTitle;
            _forumThreadBody = forumThreadBody;
            _imageUrl = imageUrl;
        }
    }
    
}
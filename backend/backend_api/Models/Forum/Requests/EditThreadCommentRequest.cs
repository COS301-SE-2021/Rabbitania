namespace backend_api.Models.Forum.Requests
{
    public class EditThreadCommentRequest
    {
        private int _threadCommentId;
        private string _commentBody;
        private string _imageUrl;
        private int _likes;
        private int _dislikes;

        public EditThreadCommentRequest()
        {
        }

        public EditThreadCommentRequest(int threadCommentId, string commentBody, string imageUrl, int likes, int dislikes)
        {
            _threadCommentId = threadCommentId;
            _commentBody = commentBody;
            _imageUrl = imageUrl;
            _likes = likes;
            _dislikes = dislikes;
        }

        public int ThreadCommentId
        {
            get => _threadCommentId;
            set => _threadCommentId = value;
        }

        public string CommentBody
        {
            get => _commentBody;
            set => _commentBody = value;
        }

        public string ImageUrl
        {
            get => _imageUrl;
            set => _imageUrl = value;
        }

        public int Likes
        {
            get => _likes;
            set => _likes = value;
        }

        public int Dislikes
        {
            get => _dislikes;
            set => _dislikes = value;
        }
    }
}
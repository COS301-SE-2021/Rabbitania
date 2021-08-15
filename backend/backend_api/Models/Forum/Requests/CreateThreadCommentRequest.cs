using System;

namespace backend_api.Models.Forum.Requests
{
    public class CreateThreadCommentRequest
    {


        private int _threadCommentId;
        private string _commentBody;
        private DateTime _createdDate;
        private string _imageUrl;
        private int _likes;
        private int _dislikes;
        private int _userId;
        private int _forumThreadId;

        public CreateThreadCommentRequest(int threadCommentId, string commentBody, DateTime createdDate,
            string imageUrl, int likes, int dislikes, int userId, int forumThreadId)
        {
            _threadCommentId = threadCommentId;
            _commentBody = commentBody;
            _createdDate = createdDate;
            _imageUrl = imageUrl;
            _likes = likes;
            _dislikes = dislikes;
            _userId = userId;
            _forumThreadId = forumThreadId;
        }

        public CreateThreadCommentRequest()
        {
            
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

        public DateTime CreatedDate
        {
            get => _createdDate;
            set => _createdDate = value;
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
        
        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }

        public int ForumThreadId
        {
            get => _forumThreadId;
            set => _forumThreadId = value;
        }

        
    }
    
}
using System;

namespace backend_api.Models.Forum.Requests
{
    public class CreateForumRequest
    {
        private int _forumId;
        private string _forumTitle;
        private DateTime _createdDate;
        private int _userId;

        public CreateForumRequest(int forumId, string forumTitle, DateTime createdDate, int userId)
        {
            _forumId = forumId;
            _forumTitle = forumTitle;
            _createdDate = createdDate;
            _userId = userId;
        }

        public CreateForumRequest()
        {
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

        public DateTime CreatedDate
        {
            get => _createdDate;
            set => _createdDate = value;
        }

        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }
    }
}
using backend_api.Models.NoticeBoard.Requests;

namespace backend_api.Models.Forum.Requests
{
    public class DeleteForumRequest
    {

        private int _forumId;
        
        public DeleteForumRequest()
        {
            
        }

        public DeleteForumRequest(int ForumId)
        {
            _forumId = ForumId;
        }

        public int ForumId
        {
            get => _forumId;
            set => _forumId = value;
        }
    }
}
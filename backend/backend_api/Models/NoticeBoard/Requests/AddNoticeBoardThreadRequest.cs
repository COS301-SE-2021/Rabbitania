using backend_api.Models.User;
using Microsoft.AspNetCore.SignalR;

namespace backend_api.Models.NoticeBoard.Requests
{
    public class AddNoticeBoardThreadRequest
    {
        private int _threadId;
        private string _threadTitle;
        private string _threadContent;
        private int _minLevel;
        private string _imageUrl;
        private UserRoles _permittedUserRoles;
        private int _userId;

        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }

        /*
        public int ThreadId
        {
            get => _threadId;
            set => _threadId = value;
        }
        */

        public string ThreadTitle
        {
            get => _threadTitle;
            set => _threadTitle = value;
        }

        public string ThreadContent
        {
            get => _threadContent;
            set => _threadContent = value;
        }

        public int MinLevel
        {
            get => _minLevel;
            set => _minLevel = value;
        }

        public string ImageUrl
        {
            get => _imageUrl;
            set => _imageUrl = value;
        }

        public UserRoles PermittedUserRoles
        {
            get => _permittedUserRoles;
            set => _permittedUserRoles = value;
        }

        

        public AddNoticeBoardThreadRequest()
        {
           
        }
        
        public AddNoticeBoardThreadRequest(string threadTitle, string threadContent, int minLevel,
            string imageUrl, UserRoles permittedUserRoles, int userId)
        {
            /*_threadId = threadId;*/
            _threadTitle = threadTitle;
            _threadContent = threadContent;
            _minLevel = minLevel;
            _imageUrl = imageUrl;
            _permittedUserRoles = permittedUserRoles;
            _userId = userId;
        }
        
        
    }
}
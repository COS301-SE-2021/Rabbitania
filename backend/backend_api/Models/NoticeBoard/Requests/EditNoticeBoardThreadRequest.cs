using backend_api.Models.Enumerations;
using backend_api.Models.User;

namespace backend_api.Models.NoticeBoard.Requests
{
    public class EditNoticeBoardThreadRequest
    {
        private int _threadId;
        private string _threadTitle;
        private string _threadContent;
        private int _minLevel;
        private string _imageUrl;
        private UserRoles _permittedUserRoles;
        private int _userId;
        private int _icon1;
        private int _icon2;
        private int _icon3;
        private int _icon4;

        public EditNoticeBoardThreadRequest(int threadId, string threadTitle, string threadContent, int minLevel, string imageUrl, UserRoles permittedUserRoles, int userId, int icon1, int icon2, int icon3, int icon4)
        {
            _threadId = threadId;
            _threadTitle = threadTitle;
            _threadContent = threadContent;
            _minLevel = minLevel;
            _imageUrl = imageUrl;
            _permittedUserRoles = permittedUserRoles;
            _userId = userId;
            _icon1 = icon1;
            _icon2 = icon2;
            _icon3 = icon3;
            _icon4 = icon4;
        }

        public int ThreadId
        {
            get => _threadId;
            set => _threadId = value;
        }

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

        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }

        public int Icon1
        {
            get => _icon1;
            set => _icon1 = value;
        }

        public int Icon2
        {
            get => _icon2;
            set => _icon2 = value;
        }

        public int Icon3
        {
            get => _icon3;
            set => _icon3 = value;
        }

        public int Icon4
        {
            get => _icon4;
            set => _icon4 = value;
        }
    }
}
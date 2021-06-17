namespace backend_api.Models.User.Requests
{
    public class CreateEmailRequest
    {
        private int _userID;
        private string _email;
        private int _emailID;

        public CreateEmailRequest(int userId, string email, int emailId)
        {
            _userID = userId;
            _email = email;
            _emailID = emailId;
        }

        public CreateEmailRequest()
        {
        }

        public int UserId
        {
            get => _userID;
            set => _userID = value;
        }

        public string Email
        {
            get => _email;
            set => _email = value;
        }

        public int EmailId
        {
            get => _emailID;
            set => _emailID = value;
        }
    }
}
namespace backend_api.Models.User.Requests
{
    public class CreateEmailRequest
    {
        private string _email;
        private int _userId;
        
        public CreateEmailRequest(string email, int userId)
        {
            //_userID = userId;
            _email = email;
            _userId = userId;
        }

        public CreateEmailRequest()
        {
        }

        public string Email
        {
            get => _email;
            set => _email = value;
        }

        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }
    }
}
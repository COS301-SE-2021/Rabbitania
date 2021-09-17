namespace backend_api.Models.User.Requests
{
    public class GetUserByEmailRequest
    {
        private string _email;

        public GetUserByEmailRequest(string email)
        {
            this._email = email;
        }

        public GetUserByEmailRequest()
        {
        }

        public string Email
        {
            get => _email;
            set => _email = value;
        }
    }
}
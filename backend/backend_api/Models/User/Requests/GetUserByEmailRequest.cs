namespace backend_api.Models.User.Requests
{
    public class GetUserByEmailRequest
    {
        private string email;

        public GetUserByEmailRequest(string email)
        {
            this.email = email;
        }

        public GetUserByEmailRequest()
        {
        }

        public string Email
        {
            get => email;
            set => email = value;
        }
    }
}
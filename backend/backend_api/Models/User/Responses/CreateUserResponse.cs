namespace backend_api.Models.User.Responses
{
    public class CreateUserResponse
    {
        private string _response;

        public CreateUserResponse(string response)
        {
            _response = response;
        }

        public CreateUserResponse()
        {
        }

        public string Response
        {
            get => _response;
            set => _response = value;
        }
    }
}
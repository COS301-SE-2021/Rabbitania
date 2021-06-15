namespace backend_api.Models.User.Responses
{
    public class EditProfileResponse
    {
        private string _message;
        
        public EditProfileResponse(string message)
        {
            this._message = message;
        }

        public string Message
        {
            get => _message;
            set => _message = value;
        }
    }
}
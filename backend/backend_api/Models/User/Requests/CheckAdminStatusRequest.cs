namespace backend_api.Models.User.Requests
{
    public class CheckAdminStatusRequest
    {
        private string _userEmail;

        public CheckAdminStatusRequest(string userEmail)
        {
            this._userEmail = userEmail;
        }

        public string UserEmail
        {
            get => _userEmail;
            set => _userEmail = value;
        }
    }
}
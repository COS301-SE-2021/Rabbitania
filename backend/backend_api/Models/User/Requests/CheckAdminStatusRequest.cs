namespace backend_api.Models.User.Requests
{
    public class CheckAdminStatusRequest
    {
        private string userEmail;

        public CheckAdminStatusRequest(string userEmail)
        {
            this.userEmail = userEmail;
        }

        public string UserEmail
        {
            get => userEmail;
            set => userEmail = value;
        }
    }
}
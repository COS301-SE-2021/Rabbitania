using System.Runtime.Versioning;

namespace backend_api.Models.Node.Requests
{
    public class ActivateNodeRequest
    {
        private string userEmail;

        public ActivateNodeRequest(string userEmail)
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
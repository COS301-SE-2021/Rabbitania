using Microsoft.EntityFrameworkCore.Storage;

namespace backend_api.Models.Auth.Responses
{
    public class LoginResponse
    {
        private bool _emailExists;

        public LoginResponse()
        {
            
        }

        public LoginResponse(bool emailExists)
        {
            this._emailExists = emailExists;
        }
        

        public bool EmailExists
        {
            get => _emailExists;
            set => _emailExists = value;
        }
    }
}
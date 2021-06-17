using System;
using Microsoft.IdentityModel.JsonWebTokens;

namespace backend_api.Models.Auth.Requests
{
    public class GoogleSignInRequest
    {
        private String _email;

        public GoogleSignInRequest()
        {
            
        }

        public GoogleSignInRequest(String email)
        {
            this._email = email;
        }
        
        public String Email
        {
            get => _email;
            set => _email = value;
        }
    }
}
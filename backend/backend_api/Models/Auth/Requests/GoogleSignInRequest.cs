using System;
using Microsoft.IdentityModel.JsonWebTokens;

namespace backend_api.Models.Auth.Requests
{
    public class GoogleSignInRequest
    {
        private String _jwt;
        private String _name;
        private String _email;

        public GoogleSignInRequest()
        {
            
        }

        public GoogleSignInRequest(String email)
        {
            this._email = email;
        }
        public GoogleSignInRequest(String jwt, String email, String name)
        {
            this._jwt = jwt;
            this._name = name;
            this._email = email;
        }

        public String Jwt
        {
            get => _jwt;
            set => _jwt = value;
        }
        public String Name
        {
            get => _name;
            set => _name = value;
        }
        public String Email
        {
            get => _email;
            set => _email = value;
        }
    }
}
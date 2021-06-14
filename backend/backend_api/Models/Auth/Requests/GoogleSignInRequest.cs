using System;
using Microsoft.IdentityModel.JsonWebTokens;

namespace backend_api.Models.Auth.Requests
{
    public class GoogleSignInRequest
    {
        private JsonWebToken jwt { get; set; }
        private String _name { get; set; }
        private String _email { get; set; }
    }
}
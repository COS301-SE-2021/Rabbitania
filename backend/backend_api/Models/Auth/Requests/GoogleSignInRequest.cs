using Microsoft.IdentityModel.JsonWebTokens;

namespace backend_api.Models.Auth.Requests
{
    public class GoogleSignInRequest
    {
        private JsonWebToken jwt { get; set; }
    }
}
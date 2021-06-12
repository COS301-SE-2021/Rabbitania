using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace backend_api.Controllers.Auth
{
    [AllowAnonymous, Route("signin-google")]
    public class GoogleSignIn : ControllerBase
    {
        public GoogleResponse signIn(GoogleSignInRequest request)
        {
            
            
            GoogleResponse response = new GoogleResponse();
            return response;
        }
    }
}
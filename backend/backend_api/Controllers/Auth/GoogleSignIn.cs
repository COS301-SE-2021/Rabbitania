using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace backend_api.Controllers.Auth
{
    [AllowAnonymous, Route("GoogleSignIn")]
    public class GoogleSignIn : Controller
    {
        
    }
}
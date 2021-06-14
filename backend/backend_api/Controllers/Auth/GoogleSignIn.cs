using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Routing;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using JsonSerializer = System.Text.Json.JsonSerializer;

namespace backend_api.Controllers.Auth
{
    [ApiExplorerSettings(IgnoreApi = true)]
    [AllowAnonymous, Route("api/[controller]")]
    [ApiController]
    public class GoogleSignIn : ControllerBase
    {
        [HttpGet]
        [Route("signin-google")]
        public IActionResult signIn()
        {
            var properties = new AuthenticationProperties {RedirectUri = Url.Action("GoogleResponse")};
            return Challenge(properties, GoogleDefaults.AuthenticationScheme);
        }
        [HttpGet]
        [Route("google-response")]
        public async Task<String> GoogleResponse()
        {
            var result = await HttpContext.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            var claims = result.Principal.Identities.FirstOrDefault().Claims.Select(claim => new
            {
                claim.Issuer,
                claim.OriginalIssuer,
                claim.Type,
                claim.Value
            }).ToList();
            
            //Creating Google response object
            var token = claims[0].Value;
            var email = claims[(claims.Count)-1].Value;
            var givenName = claims[1].Value;
            var name = claims[2].Value;
            var surname = "";
            if (claims.Capacity > 4)
            {
                surname = claims[3].Value;
            }
            //TODO: populate result instead of the json method
            GoogleResponse response = new GoogleResponse(email, token, givenName, name, surname);

            return response.json().ToString();
        }
    }
}
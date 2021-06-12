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
using Newtonsoft.Json;
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
            // var options = new JsonSerializerOptions
            // {
            //     AllowTrailingCommas = true
            // };
            var json = JsonSerializer.Serialize(claims);
            return json;
        }
    }
}
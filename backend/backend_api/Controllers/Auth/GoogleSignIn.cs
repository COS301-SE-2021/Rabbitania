using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
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
using backend_api.Exceptions.Auth;
using backend_api.Services.Auth;
using backend_api.Services.User;
using Microsoft.AspNetCore.Routing;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using JsonSerializer = System.Text.Json.JsonSerializer;

namespace backend_api.Controllers.Auth
{
    
    [AllowAnonymous, Route("api/[controller]")]
    [ApiController]
    public class GoogleSignIn : ControllerBase
    {
        private readonly IAuthService _service;
        private readonly IUserService _userService;
        public GoogleSignIn(IAuthService service, IUserService userService)
        {
            this._service = service;
            this._userService = userService;
        }
        

        /*[HttpGet]
        [Route("GoogleLoginv1")]
        public IActionResult signIn()
        {
            var properties = new AuthenticationProperties {RedirectUri = Url.Action("GoogleResponse")};
            return Challenge(properties, GoogleDefaults.AuthenticationScheme);
        }*/

        [HttpPost]
        [Route("GoogleLogin")]
        public async Task<ActionResult> GoogleResponse(GoogleSignInRequest request)
        {
            //Task<String>
            // var result = await HttpContext.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            // var claims = result.Principal.Identities.FirstOrDefault().Claims.Select(claim => new
            // {
            //     claim.Issuer,
            //     claim.OriginalIssuer,
            //     claim.Type,
            //     claim.Value
            // }).ToList();
            //
            // //Creating Google response object
            // var token = claims[0].Value;
            // var email = claims[(claims.Count) - 1].Value;
            // var givenName = claims[1].Value;
            // var name = claims[2].Value;
            // var surname = "";
            // //not every account has provided a surname
            // if (claims.Capacity > 4)
            // {
            //     surname = claims[3].Value;
            // }
            
            var email = request.Email;

            GoogleResponse response = new GoogleResponse();
            
            try
            {
                //check if correct domain
                if (_service.CheckEmailDomain(request).CorrectDomain)
                {
                    //check if email exists in databse, otherwise user must register
                    if (_service.checkEmailExists(request).EmailExists)
                    {
                        var json = _service.GetUser(request);

                        //user exists, return missing info as json object
                        return Ok(json);
                    }
                    else //user doesn't exist and needs to be thrown
                    {
                        // user needs to be added as they are a valid retro rabbit employee
                        // but are not in the system yet.
                        await _userService.CreateUser(request);
                        return Ok("all good in the hood");
                        //throw new InvalidEmailException("Email does not exist in database");
                    }
                }
                else
                {
                    throw new InvalidDomainException("Domain in not part of the retro rabbit workspace");
                }
            }
            catch (Exception e)
            {
                throw e;
            }

            // return response.json().ToString();
        }
    }
}
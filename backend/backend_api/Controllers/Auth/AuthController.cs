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
using backend_api.Models.Auth;
using backend_api.Models.User.Requests;
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
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _service;
        private readonly IUserService _userService;
        public AuthController(IAuthService service, IUserService userService)
        {
            this._service = service;
            this._userService = userService;
        }

        /// <summary>
        ///     API endpoint for logging in with Google credentials
        ///     Checks if the email is of the correct domain and if it exists in the system
        ///     If the domain is incorrect, an InvalidDomainException is thrown
        ///     If the domain is correct but the email does not exist, a user is created and the 201
        ///     response code is returned.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Http response code</returns>
        [HttpPost]
        [Route("GoogleLogin")]
        public async Task<ActionResult> GoogleResponse(GoogleSignInRequest request)
        {

            var email = request.Email;

            var response = new GoogleResponse();
            
            try
            {
                //check if correct domain
                if (_service.CheckEmailDomain(request).CorrectDomain)
                {
                    //check if email exists in database, otherwise user must register
                    if (_service.checkEmailExists(request).Result.EmailExists)
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
                        return Created("", "User has been created.");
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
        
        /// <summary>
        ///     API endpoint for GetUserID
        ///     Returns the corresponding user ID from the user's email address
        /// </summary>
        /// <param name="email"></param>
        /// <returns>integer</returns>
        [HttpGet, Authorize]
        [Route("GetID")]
        public async Task<int> GetUserId(string email)
        {
            var request = new GoogleSignInRequest(email);
            var resp = await _service.GetUserID(request);
            var userId = resp.UserId;
            return userId;
        }

        [HttpPost,Authorize]
        [Route("Auth")]
        public async Task<IActionResult> Auth([FromBody] Credentials credentials)
        {
            if (!ModelState.IsValid)
                return BadRequest();

            if (!await _service.Validate(credentials))
            {
                return Unauthorized();
            }

            return Ok(new {token = await _service.createJwt(credentials)});
        }
    }
}
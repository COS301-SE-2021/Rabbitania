﻿using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Exceptions.Auth;
using backend_api.Exceptions.User;
using backend_api.Models.Auth;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using backend_api.Models.User.Requests;
using backend_api.Services.User;
using Castle.Core.Configuration;
using FirebaseAdmin.Auth;
using Google.Apis.Auth;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Authentication.OAuth;

namespace backend_api.Services.Auth
{
    public class AuthService : IAuthService
    {
        private readonly IUserRepository _repository;
        private readonly IUserService _userService;
        private readonly IConfiguration _configuration;

        public AuthService(IUserRepository repository, IUserService userService, IConfiguration configuration)
        {
            _repository = repository;
            _userService = userService;
            _configuration = configuration;
        }

        public AuthService(IUserRepository repository, IUserService userService)
        {
            _repository = repository;
            _userService = userService;
        }
        
        /// <inheritdoc />
        public async Task<LoginResponse> checkEmailExists(GoogleSignInRequest request)
        {
            // throw new System.NotImplementedException();
            String email = request.Email;
            if (email == null)
            {
                throw new NullEmailException("User Email Missing");
            }
            //Checks if email received by request is in the UserEmails repo
            if(_repository.checkEmailExists(request).Result)
            {
                return new LoginResponse(true);
            }
            else
            {
                return new LoginResponse(false);
            }
        }

        public AuthService(IUserRepository repository)
        {
            this._repository = repository;
        }
        
        /// <inheritdoc />
        public DomainResponse CheckEmailDomain(GoogleSignInRequest request)
        {
            var email = request.Email;
            var arr = email.Split('@');
            //TODO: Change to retrorabbit.co.za once we have a test email to work with
            if (arr[1].Equals("gmail.com"))
            {
                return new DomainResponse(true);
            }
            else
            {
                return new DomainResponse(false);
            }
        }
        
        /// <inheritdoc />
        public JObject GetUser(GoogleSignInRequest request)
        {
            try
            {
                var user = _repository.GetExistingUserDetails(request).Result;
                JObject json = new JObject(
                    new JProperty("description", user.UserDescription),
                    new JProperty("pinnedIDs", user.PinnedUserIds.ToArray()),
                    new JProperty("admin", user.IsAdmin),
                    new JProperty("role", user.UserRole.ToString()),
                    new JProperty("empLevel", user.EmployeeLevel),
                    new JProperty("office", user.OfficeLocation.ToString()),
                    new JProperty("email", request.Email));
                return json;
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw e;
            }
        }
        
        /// <inheritdoc />
        public async Task<Models.User.Users> GetUserName(string name)
        {
            try
            {
                var resp = await _repository.GetUser(name);
                var user = resp.FirstOrDefault();
                return user;
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw new InvalidUserRequest("The user does not exist in the database");
            }
            
        }
        
        /// <inheritdoc />
        public async Task<Models.User.Users> GetUserId(GoogleSignInRequest request)
        {
            try
            {
                var user = await _repository.GetExistingUserDetails(request);
                return user;
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw new InvalidUserRequest("The user does not exist in the database");
            }
            
        }
        
        /// <inheritdoc />
        public async Task<Models.User.Users> GetUserAdminStatus(GoogleSignInRequest request)
        {
            try
            {
                var user = await _repository.GetExistingUserDetails(request);
                return user;
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw new InvalidUserRequest("The user does not exist in the database");
            }
            
        }
        
        /// <inheritdoc />
        public async Task<bool> Validate(Credentials credentials)
        {
            
            var email = credentials.Email;
            var req = new GetUserByEmailRequest(email);
            
            try
            {
                var resp = await _userService.GetUserByEmail(req);
                return resp!=null || true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        
        /// <inheritdoc />
        public async Task<string> createJwt(Credentials credentials)
        {
            var settings = Startup.StaticConfig.GetSection("JwtSettings");
            var secret = Environment.GetEnvironmentVariable("JWTSecret") ?? string.Empty;
            var claims = await GetClaims(credentials);

            var signingKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secret));
            var signingCred = new SigningCredentials(signingKey, SecurityAlgorithms.HmacSha256);
            
            var token = new JwtSecurityToken(
                issuer: settings.GetSection("validIssuer").Value,
                audience: settings.GetSection("validAudience").Value,
                claims: claims,
                expires: DateTime.Now.AddMinutes(120),
                signingCredentials: signingCred
                );
            return new JwtSecurityTokenHandler().WriteToken(token);
        }
        
        public async Task<List<Claim>> GetClaims(Credentials credentials)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, credentials.Name)
            };
            
            return claims;
        }
        public async Task<bool> ValidateGoogleAccount(string token)
        {
            var valid = false;
            try
            {
                var validData = await GoogleJsonWebSignature.ValidateAsync(token);
                Console.Write(validData);
                if (validData != null)
                {
                    valid = true;
                }
            }
            catch (InvalidJwtException e)
            {
                Console.Write(e.Message);
            }

            // bool valid = false;
            // const string GoogleAPIURL = "https://oauth2.googleapis.com/tokeninfo?id_token={0}";
            // var httpClient = new HttpClient();
            // var requestUri = new Uri(string.Format(GoogleAPIURL, token));
            //
            // HttpResponseMessage httpResponseMessage;
            // try
            // {
            //     httpResponseMessage = httpClient.GetAsync(requestUri).Result;
            // }
            // catch (Exception)
            // {
            //     throw new Exception("Error trying to call Google authenticate endpoint to verify user login");
            // }
            //
            // if (httpResponseMessage.StatusCode != HttpStatusCode.OK)
            // {
            //     return false;
            // }
            //
            // var resp = httpResponseMessage.Content.ReadAsStringAsync().Result;
            // var googleTokenInfo = JsonConvert.DeserializeObject<GoogleToken>(resp);
            //
            return valid;
        }
    }
}
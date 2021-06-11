using System;
using System.Data;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using backend_api.User.Models.Responses;
using Microsoft.IdentityModel.JsonWebTokens;

namespace backend_api.User.Models.Requests
{
    public class GetUserRequest
    {
        //TODO: implement request to use jwt token from google Oauth
        //private JsonWebToken jwt;
        
        // public GetUserRequest(JsonWebToken jwt)
        // {
        //     this.jwt = jwt;
        // }

        // public JsonWebToken getToken()
        // {
        //     return jwt;
        // }
        //----------------------------------------------------------------------------------
        private String userEmail;

        public GetUserRequest(String email)
        {
            this.userEmail = email;
        }

        public String getEmail()
        {
            return this.userEmail;
        }
    }
}
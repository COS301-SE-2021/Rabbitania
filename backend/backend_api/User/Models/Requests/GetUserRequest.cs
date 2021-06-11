using System;
using System.Data;

namespace backend_api.User.Models.Requests
{
    public class GetUserRequest
    {
        private String jwt;

        public GetUserRequest(String jwt)
        {
            this.jwt = jwt;
        }

        public String getToken()
        {
            return jwt;
        }

    }
}
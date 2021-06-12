using System;

namespace backend_api.Models.User.Requests
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
        private String firstname;
        private String surname;

        public GetUserRequest(String firstname, String lastname)
        {
            this.firstname = firstname;
            this.surname = lastname;
        }

        public String getName()
        {
            return this.firstname;
        }

        public String getSurname()
        {
            return this.surname;
        }
    }
}
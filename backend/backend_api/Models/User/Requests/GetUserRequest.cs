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
        private string firstname;
        private string surname;

        public GetUserRequest(string firstname, string lastname)
        {
            this.firstname = firstname;
            this.surname = lastname;
        }

        public string getName()
        {
            return this.firstname;
        }

        public string getSurname()
        {
            return this.surname;
        }
    }
}
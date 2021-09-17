using System;

namespace backend_api.Models.User.Requests
{
    public class GetUserRequest
    {
        private string _firstname;
        private string _surname;

        public GetUserRequest()
        {
            
        }
        
        public GetUserRequest(string firstname, string lastname)
        {
            this._firstname = firstname;
            this._surname = lastname;
        }

        public string getName()
        {
            return this._firstname;
        }

        public string getSurname()
        {
            return this._surname;
        }
    }
}
using System;

namespace backend_api.Models.User.Requests
{
    public class GetUserRequest
    {
        private string firstname;
        private string surname;

        public GetUserRequest()
        {
            
        }
        
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
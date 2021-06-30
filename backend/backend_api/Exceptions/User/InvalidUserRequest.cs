using System;

namespace backend_api.Exceptions.User
{
    public class InvalidUserRequest : Exception
    {
        public InvalidUserRequest()
        {
            
        }

        public InvalidUserRequest(string message) : base(message)
        {
            
        }
        
        public InvalidUserRequest(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
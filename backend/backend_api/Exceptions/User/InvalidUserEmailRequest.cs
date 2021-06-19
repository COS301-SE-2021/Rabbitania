using System;

namespace backend_api.Exceptions.User
{
    public class InvalidUserEmailRequest : Exception
    {
        public InvalidUserEmailRequest()
        {
            
        }

        public InvalidUserEmailRequest(string message) : base(message)
        {
            
        }
        
        public InvalidUserEmailRequest(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
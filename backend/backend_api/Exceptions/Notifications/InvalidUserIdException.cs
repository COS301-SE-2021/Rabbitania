using System;

namespace backend_api.Exceptions.Notifications
{
    public class InvalidUserIdException : Exception
    {
        public InvalidUserIdException()
        {
            
        }

        public InvalidUserIdException(string message) : base(message)
        {
            
        }
        
        public InvalidUserIdException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
using System;

namespace backend_api.Exceptions.Auth
{
    public class InvalidEmailException : Exception
    {
        public InvalidEmailException()
        {
            
        }

        public InvalidEmailException(string message) : base(message)
        {
            
        }
        
        public InvalidEmailException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
using System;

namespace backend_api.Exceptions.Auth
{
    public class InvalidDomainException : Exception
    {
        public InvalidDomainException()
        {
            
        }

        public InvalidDomainException(string message) : base(message)
        {
            
        }
        
        public InvalidDomainException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
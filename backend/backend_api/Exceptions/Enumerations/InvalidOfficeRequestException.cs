using System;

namespace backend_api.Exceptions.Enumerations
{
    public class InvalidOfficeRequestException : Exception
    {
        public InvalidOfficeRequestException()
        {
            
        }

        public InvalidOfficeRequestException(string message) : base(message)
        {
            
        }
        
        public InvalidOfficeRequestException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
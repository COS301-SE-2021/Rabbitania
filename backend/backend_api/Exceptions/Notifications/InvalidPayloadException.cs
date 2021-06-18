using System;

namespace backend_api.Exceptions.Notifications
{
    public class InvalidPayloadException : Exception
    {
        public InvalidPayloadException()
        {
            
        }

        public InvalidPayloadException(string message) : base(message)
        {
            
        }
        
        public InvalidPayloadException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
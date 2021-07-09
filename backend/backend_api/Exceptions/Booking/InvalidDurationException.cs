using System;

namespace backend_api.Exceptions.Booking
{
    public class InvalidDurationException : Exception
    {
        public InvalidDurationException()
        {
            
        }

        public InvalidDurationException(string message) : base(message)
        {
            
        }
        
        public InvalidDurationException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
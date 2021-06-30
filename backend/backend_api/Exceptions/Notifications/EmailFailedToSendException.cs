using System;

namespace backend_api.Exceptions.Notifications
{
    public class EmailFailedToSendException : Exception
    {
        public EmailFailedToSendException()
        {
            
        }

        public EmailFailedToSendException(string message) : base(message)
        {
            
        }
        
        public EmailFailedToSendException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
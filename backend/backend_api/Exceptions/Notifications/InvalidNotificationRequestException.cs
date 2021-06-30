using System;

namespace backend_api.Exceptions.Notifications
{
    public class InvalidNotificationRequestException: Exception
    {
        public InvalidNotificationRequestException()
        {
            
        }

        public InvalidNotificationRequestException(string message) : base(message)
        {
            
        }
        
        public InvalidNotificationRequestException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
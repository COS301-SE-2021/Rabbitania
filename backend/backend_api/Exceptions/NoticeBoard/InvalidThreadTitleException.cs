using System;

namespace backend_api.Exceptions.NoticeBoard
{
    public class InvalidThreadTitleException : Exception
    {
        public InvalidThreadTitleException()
        {
            
        }

        public InvalidThreadTitleException(string message) : base(message)
        {
            
        }
        
        public InvalidThreadTitleException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
using System;

namespace backend_api.Exceptions.NoticeBoard
{
    public class InvalidThreadContentException : Exception
    {
        public InvalidThreadContentException()
        {
            
        }

        public InvalidThreadContentException(string message) : base(message)
        {
            
        }
        
        public InvalidThreadContentException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
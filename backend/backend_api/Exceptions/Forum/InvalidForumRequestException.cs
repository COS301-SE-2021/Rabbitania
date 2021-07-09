using System;

namespace backend_api.Exceptions.Forum
{
    public class InvalidForumRequestException : Exception
    {
        public InvalidForumRequestException()
        {
        }

        public InvalidForumRequestException(string message) : base(message)
        {
            
        }

        public InvalidForumRequestException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
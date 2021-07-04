using System;

namespace backend_api.Exceptions.Forum
{
    public class InvalidForumTitleException : Exception
    {
        public InvalidForumTitleException()
        {
            
        }

        public InvalidForumTitleException(string message) : base(message)
        {
            
        }
        
        public InvalidForumTitleException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
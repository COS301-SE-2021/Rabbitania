using System;

namespace backend_api.Exceptions.Enumerations
{
    public class InvalidUserRoleTypeException : Exception
    {
        public InvalidUserRoleTypeException()
        {
            
        }

        public InvalidUserRoleTypeException(string message) : base(message)
        {
            
        }
        
        public InvalidUserRoleTypeException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
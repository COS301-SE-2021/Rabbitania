﻿using System;

namespace backend_api.Exceptions.User
{
    public class InvalidUserRequestException : Exception
    {
        public InvalidUserRequestException()
        {
            
        }

        public InvalidUserRequestException(string message) : base(message)
        {
            
        }
        
        public InvalidUserRequestException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
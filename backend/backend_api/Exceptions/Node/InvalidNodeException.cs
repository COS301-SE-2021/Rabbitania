using System;
using System.Runtime.Serialization;

namespace backend_api.Exceptions.Node
{
    public class InvalidNodeException : Exception
    {
        public InvalidNodeException()
        {
        }

        public InvalidNodeException(string? message) : base(message)
        {
        }

        public InvalidNodeException(string? message, Exception? innerException) : base(message, innerException)
        {
        }
    }
}
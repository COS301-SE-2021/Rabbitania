using System;
using System.Runtime.Serialization;

namespace backend_api.Exceptions.Auth
{
    public class NullEmailException: Exception
    {
        public NullEmailException()
        {
        }

        public NullEmailException(string message) : base(message)
        {
        }

        public NullEmailException(string message, Exception innerException) : base(message, innerException)
        {
        }
    }
}
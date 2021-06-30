using System;

namespace backend_api.Exceptions.NoticeBoard
{
    public class InvalidNoticeBoardRequestException : Exception
    {
        public InvalidNoticeBoardRequestException()
        {
        }

        public InvalidNoticeBoardRequestException(string message) : base(message)
        {
            
        }

        public InvalidNoticeBoardRequestException(string message, Exception inner) : base(message, inner)
        {
            
        }
    }
}
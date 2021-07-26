using System.Net;
using backend_api.Exceptions.Forum;
using backend_api.Models.Forum.Requests;

namespace backend_api.Models.Forum.Responses
{
    public class DeleteForumThreadResponse
    {
        private HttpStatusCode _httpStatusCode;
        private InvalidForumRequestException _exception;

        public DeleteForumThreadResponse()
        {
            
        }

        public DeleteForumThreadResponse(HttpStatusCode httpStatusCode)
        {
            _httpStatusCode = httpStatusCode;
        }

        public DeleteForumThreadResponse(HttpStatusCode code, InvalidForumRequestException e)
        {
            _httpStatusCode = code;
            _exception = e;
        }

        public HttpStatusCode HttpStatusCode
        {
            get => _httpStatusCode;
            set => _httpStatusCode = value;
        }
    }
}
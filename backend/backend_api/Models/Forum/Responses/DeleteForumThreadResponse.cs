using System.Net;
using backend_api.Models.Forum.Requests;

namespace backend_api.Models.Forum.Responses
{
    public class DeleteForumThreadResponse
    {
        private HttpStatusCode _httpStatusCode;

        public DeleteForumThreadResponse()
        {
            
        }

        public DeleteForumThreadResponse(HttpStatusCode httpStatusCode)
        {
            _httpStatusCode = httpStatusCode;
        }

        public HttpStatusCode HttpStatusCode
        {
            get => _httpStatusCode;
            set => _httpStatusCode = value;
        }
    }
}
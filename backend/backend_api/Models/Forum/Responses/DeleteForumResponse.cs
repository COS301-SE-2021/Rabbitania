using System.Net;

namespace backend_api.Models.Forum.Responses
{

    public class DeleteForumResponse
    {
        private HttpStatusCode _httpStatusCode;
        
        public DeleteForumResponse(HttpStatusCode httpStatusCode)
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
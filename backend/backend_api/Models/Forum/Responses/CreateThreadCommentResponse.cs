using System.Net;
using backend_api.Exceptions.Forum;
using backend_api.Models.Forum.Requests;

namespace backend_api.Models.Forum.Responses
{
    public class CreateThreadCommentResponse
    {
        private HttpStatusCode _response;

        public CreateThreadCommentResponse(HttpStatusCode response)
        {
            _response = response;
        }
        
        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }
    }
}
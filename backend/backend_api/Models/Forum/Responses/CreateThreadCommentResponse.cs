using System.Net;
using backend_api.Exceptions.Forum;
using backend_api.Models.Forum.Requests;

namespace backend_api.Models.Forum.Responses
{
    public class CreateThreadCommentResponse
    {
        private HttpStatusCode _response;
        private InvalidForumRequestException _exception;

        public CreateThreadCommentResponse(HttpStatusCode response)
        {
            _response = response;
        }

        public CreateThreadCommentResponse(HttpStatusCode response, InvalidForumRequestException e)
        {
            _response = response;
            _exception = e;
        }
        
        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }

        public InvalidForumRequestException Exception
        {
            get => _exception;
            set => _exception = value;
        }
    }
}
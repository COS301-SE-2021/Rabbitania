using System.Net;
using backend_api.Exceptions.Forum;

namespace backend_api.Models.Forum.Responses
{
    public class CreateForumThreadResponse
    {
        private HttpStatusCode _response;
        private InvalidForumRequestException _exception;
        public InvalidForumRequestException Exception
        {
            get => _exception;
            set => _exception = value;
        }

        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }

        public CreateForumThreadResponse(HttpStatusCode response)
        {
            _response = response;
        }
        public CreateForumThreadResponse(HttpStatusCode response, InvalidForumRequestException e)
        {
            _response = response;
            _exception = e;
        }
    }
}
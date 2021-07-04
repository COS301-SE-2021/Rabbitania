using System.Net;

namespace backend_api.Models.Forum.Responses
{
    public class CreateForumResponse
    {
        private HttpStatusCode _response;

        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }

        public CreateForumResponse(HttpStatusCode response)
        {
            _response = response;
        }
    }
}
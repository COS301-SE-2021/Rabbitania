using System.Net;

namespace backend_api.Models.Forum.Responses
{
    public class DeleteThreadCommentResponse
    {
        private HttpStatusCode _response;

        public DeleteThreadCommentResponse(HttpStatusCode response)
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
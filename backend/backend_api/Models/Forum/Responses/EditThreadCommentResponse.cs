using System.Net;

namespace backend_api.Models.Forum.Responses
{
    public class EditThreadCommentResponse
    {
        private HttpStatusCode _response;

        public EditThreadCommentResponse(HttpStatusCode response)
        {
            _response = response;
        }

        public EditThreadCommentResponse()
        {
        }

        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }
    }
}
using System.Net;

namespace backend_api.Models.Forum.Responses
{
    public class EditForumThreadResponse
    {
        private HttpStatusCode _response;

        public EditForumThreadResponse(HttpStatusCode response)
        {
            _response = response;
        }

        public EditForumThreadResponse()
        {
        }

        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }
    }
}
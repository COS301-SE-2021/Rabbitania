using System.Net;

namespace backend_api.Models.User.Responses
{
    public class EditProfileResponse
    {
        private HttpStatusCode _response;

        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }

        public EditProfileResponse(HttpStatusCode message)
        {
            _response = message;
        }

      
    }
}
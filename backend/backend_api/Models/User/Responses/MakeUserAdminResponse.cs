using System.Net;

namespace backend_api.Models.User.Responses
{
    public class MakeUserAdminResponse
    {
        
        private string _response;
        private HttpStatusCode _statusCode;

        public MakeUserAdminResponse(string response, HttpStatusCode statusCode)
        {
            this._response = response;
            this._statusCode = statusCode;
        }
        
        public string Response
        {
            get => _response;
            set => _response = value;
        }

        public HttpStatusCode StatusCode
        {
            get => _statusCode;
            set => _statusCode = value;
        }

       
    }
}
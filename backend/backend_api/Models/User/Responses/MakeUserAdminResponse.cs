using System.Net;

namespace backend_api.Models.User.Responses
{
    public class MakeUserAdminResponse
    {
        
        private string response;
        private HttpStatusCode _statusCode;

        public MakeUserAdminResponse(string response, HttpStatusCode statusCode)
        {
            this.response = response;
            _statusCode = statusCode;
        }
        
        public string Response
        {
            get => response;
            set => response = value;
        }

        public HttpStatusCode StatusCode
        {
            get => _statusCode;
            set => _statusCode = value;
        }

       
    }
}
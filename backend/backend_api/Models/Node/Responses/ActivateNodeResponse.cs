using System.Net;

namespace backend_api.Models.Node.Responses
{
    public class ActivateNodeResponse
    {
        private string response;
        private HttpStatusCode _statusCode;
        
        public ActivateNodeResponse(string response, HttpStatusCode statusCode)
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

        public ActivateNodeResponse(string response)
        {
            this.response = response;
        }
    }
    
    
    
    
}
using System.Net;

namespace backend_api.Models.Node.Responses
{
    public class ActivateNodeResponse
    {
        private string _response;
        private HttpStatusCode _statusCode;
        
        public ActivateNodeResponse(string response, HttpStatusCode statusCode)
        {
            this._response = response;
            _statusCode = statusCode;
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

        public ActivateNodeResponse(string response)
        {
            this._response = response;
        }
    }
    
    
    
    
}
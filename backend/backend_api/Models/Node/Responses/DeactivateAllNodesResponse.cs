using System.Net;

namespace backend_api.Models.Node.Responses
{
    public class DeactivateAllNodesResponse
    {
        private string _response;
        private HttpStatusCode _statusCode;

        public DeactivateAllNodesResponse(string response, HttpStatusCode statusCode)
        {
            _statusCode = statusCode;
            this._response = response;
        }

        public HttpStatusCode StatusCode
        {
            get => _statusCode;
            set => _statusCode = value;
        }

        public string Response
        {
            get => _response;
            set => _response = value;
        }

        public DeactivateAllNodesResponse(string response)
        {
            this._response = response;
        }
    }
}
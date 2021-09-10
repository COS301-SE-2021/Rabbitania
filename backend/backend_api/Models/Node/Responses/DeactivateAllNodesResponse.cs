using System.Net;

namespace backend_api.Models.Node.Responses
{
    public class DeactivateAllNodesResponse
    {
        private string response;
        private HttpStatusCode _statusCode;

        public DeactivateAllNodesResponse(string response, HttpStatusCode statusCode)
        {
            _statusCode = statusCode;
            this.response = response;
        }

        public HttpStatusCode StatusCode
        {
            get => _statusCode;
            set => _statusCode = value;
        }

        public string Response
        {
            get => response;
            set => response = value;
        }

        public DeactivateAllNodesResponse(string response)
        {
            this.response = response;
        }
    }
}
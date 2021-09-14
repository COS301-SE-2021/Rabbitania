using System.Net;

namespace backend_api.Models.Node.Responses
{
    public class SaveNodesResponse
    {
        private string _response;
        private HttpStatusCode _statusCode;

        public SaveNodesResponse(string response, HttpStatusCode statusCode)
        {
            _response = response;
            _statusCode = statusCode;
        }

        public SaveNodesResponse(HttpStatusCode statusCode)
        {
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
    }
}
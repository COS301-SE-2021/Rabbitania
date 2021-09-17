using System.Net;

namespace backend_api.Models.Node.Responses
{
    public class DeleteNodeResponse
    {
        private string _response;
        private HttpStatusCode _statusCode;

        public DeleteNodeResponse(string response, HttpStatusCode statusCode)
        {
            this._response = response;
            this._statusCode = statusCode;
        }

        public HttpStatusCode StatusCode
        {
            get => _statusCode;
            set => _statusCode = value;
        }

        public DeleteNodeResponse(string response)
        {
            this._response = response;
        }

        public string Response
        {
            get => _response;
            set => _response = value;
        }
    }
}
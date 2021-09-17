using System.Net;

namespace backend_api.Models.Node.Responses
{
    public class EditNodeResponse
    {
        private string _response;
        private HttpStatusCode _statusCode;
        

        public EditNodeResponse(string response, HttpStatusCode statusCode)
        {
            this._statusCode = statusCode;
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

        public EditNodeResponse(string response)
        {
            this._response = response;
        }
    }
}
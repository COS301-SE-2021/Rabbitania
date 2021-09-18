using System.Net;

namespace backend_api.Models.Node.Responses
{
    public class EditNodeResponse
    {
        private string response;
        private HttpStatusCode _statusCode;
        

        public EditNodeResponse(string response, HttpStatusCode statusCode)
        {
            this._statusCode = statusCode;
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

        public EditNodeResponse(string response)
        {
            this.response = response;
        }
    }
}
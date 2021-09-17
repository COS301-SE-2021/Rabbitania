using System.Net;

namespace backend_api.Models.Node.Responses
{
    public class DeleteNodeResponse
    {
        private string response;
        private HttpStatusCode statusCode;

        public DeleteNodeResponse(string response, HttpStatusCode statusCode)
        {
            this.response = response;
            this.statusCode = statusCode;
        }

        public HttpStatusCode StatusCode
        {
            get => statusCode;
            set => statusCode = value;
        }

        public DeleteNodeResponse(string response)
        {
            this.response = response;
        }

        public string Response
        {
            get => response;
            set => response = value;
        }
    }
}
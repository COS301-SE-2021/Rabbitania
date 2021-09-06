using System.Net;

namespace backend_api.Models.Node.Responses
{
    public class CreateNodeResponse
    {
        private string response;
        private int nodeId;
        private HttpStatusCode statusCode;

        public CreateNodeResponse(string response, HttpStatusCode statusCode)
        {
            this.response = response;
            this.statusCode = statusCode;
        }

        public CreateNodeResponse(string response, int nodeId, HttpStatusCode statusCode)
        {
            this.response = response;
            this.nodeId = nodeId;
            this.statusCode = statusCode;
        }

        public CreateNodeResponse(string response)
        {
            this.response = response;
        }

        public string Response
        {
            get => response;
            set => response = value;
        }

        public int NodeId
        {
            get => nodeId;
            set => nodeId = value;
        }

        public HttpStatusCode StatusCode
        {
            get => statusCode;
            set => statusCode = value;
        }
    }
}
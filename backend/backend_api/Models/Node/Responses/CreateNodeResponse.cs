using System.Net;

namespace backend_api.Models.Node.Responses
{
    public class CreateNodeResponse
    {
        private string response;
        private HttpStatusCode statusCode;

        public CreateNodeResponse(string response, HttpStatusCode statusCode)
        {
            this.response = response;
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
        

        public HttpStatusCode StatusCode
        {
            get => statusCode;
            set => statusCode = value;
        }
    }
}
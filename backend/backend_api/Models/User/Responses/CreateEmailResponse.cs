using System;

namespace backend_api.Models.User.Responses
{
    public class CreateEmailResponse
    {
        private string response;
    
        public CreateEmailResponse()
        {
        }

        public CreateEmailResponse(string response)
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
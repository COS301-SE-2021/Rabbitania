using System;

namespace backend_api.Models.User.Responses
{
    public class CreateEmailResponse
    {
        private string _response;
    
        public CreateEmailResponse()
        {
        }

        public CreateEmailResponse(string response)
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
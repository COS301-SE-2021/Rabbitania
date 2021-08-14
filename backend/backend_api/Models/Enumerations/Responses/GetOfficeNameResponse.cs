using System.Net;

namespace backend_api.Models.Enumerations.Responses
{
    public class GetOfficeNameResponse
    {
        private string _response;

        public GetOfficeNameResponse(string response)
        {
            this._response = response;
        }

        public GetOfficeNameResponse()
        {
        }

        public string Response
        {
            get => _response;
            set => _response = value;
        }
    }
}
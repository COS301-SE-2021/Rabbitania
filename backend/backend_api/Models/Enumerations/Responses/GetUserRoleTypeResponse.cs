namespace backend_api.Models.Enumerations.Responses
{
    public class GetUserRoleTypeResponse
    {
        private string _response;

        public GetUserRoleTypeResponse(string response)
        {
            this._response = response;
        }

        public GetUserRoleTypeResponse()
        {
        }

        public string Response
        {
            get => _response;
            set => _response = value;
        }
    }
}
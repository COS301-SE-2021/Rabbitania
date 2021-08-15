namespace backend_api.Models.Enumerations.Requests
{
    public class GetOfficeIdRequest
    {
        private string _officeName;

        public GetOfficeIdRequest(string officeName)
        {
            _officeName = officeName;
        }

        public GetOfficeIdRequest()
        {
            
        }

        public string OfficeName
        {
            get => _officeName;
            set => _officeName = value;
        }
    }
}
namespace backend_api.Models.Enumerations.Requests
{
    public class GetOfficeNameRequest
    {
        private OfficeLocation _officeLocation;

        public GetOfficeNameRequest(OfficeLocation officeLocation)
        {
            _officeLocation = officeLocation;
        }

        public GetOfficeNameRequest()
        {
        }

        public OfficeLocation OfficeLocation
        {
            get => _officeLocation;
            set => _officeLocation = value;
        }
    }
}
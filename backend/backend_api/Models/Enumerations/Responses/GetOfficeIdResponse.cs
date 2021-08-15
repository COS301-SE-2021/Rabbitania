namespace backend_api.Models.Enumerations.Responses
{
    public class GetOfficeIdResponse
    {
        private OfficeLocation _officeLocation;

        public GetOfficeIdResponse(OfficeLocation officeLocation)
        {
            _officeLocation = officeLocation;
        }

        public GetOfficeIdResponse()
        {
            
        }

        public OfficeLocation OfficeLocation
        {
            get => _officeLocation;
            set => _officeLocation = value;
        }
    }
}
namespace backend_api.Models.Auth.Responses
{
    public class DomainResponse
    {
        private bool _correctDomain;

        public DomainResponse(bool correctDomain)
        {
            _correctDomain = correctDomain;
        }
        public DomainResponse(){}

        public bool CorrectDomain
        {
            get => _correctDomain;
            set => _correctDomain = value;
        }
    }
}
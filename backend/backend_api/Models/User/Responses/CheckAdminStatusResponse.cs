using System.Net;

namespace backend_api.Models.User.Responses
{
    public class CheckAdminStatusResponse
    {
        private bool _result;
        private HttpStatusCode _status;

        public CheckAdminStatusResponse(bool result, HttpStatusCode status)
        {
            _result = result;
            _status = status;
        }

        public bool Result
        {
            get => _result;
            set => _result = value;
        }

        public HttpStatusCode Status
        {
            get => _status;
            set => _status = value;
        }

        public CheckAdminStatusResponse(HttpStatusCode status)
        {
            _status = status;
        }
    }
}
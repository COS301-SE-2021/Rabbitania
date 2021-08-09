using System.Net;

namespace backend_api.Models.NoticeBoard.Responses
{
    public class EditNoticeBoardThreadResponse
    {
        private HttpStatusCode _response;

        public EditNoticeBoardThreadResponse()
        {
        }

        public EditNoticeBoardThreadResponse(HttpStatusCode response)
        {
            _response = response;
        }

        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }
    }
}
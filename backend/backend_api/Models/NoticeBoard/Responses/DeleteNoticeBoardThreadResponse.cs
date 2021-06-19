using System.Net;
using backend_api.Models.NoticeBoard.Requests;

namespace backend_api.Models.NoticeBoard.Responses
{
    public class DeleteNoticeBoardThreadResponse
    {
        private HttpStatusCode _httpStatusCode;

        public DeleteNoticeBoardThreadResponse(HttpStatusCode httpStatusCode)
        {
            _httpStatusCode = httpStatusCode;
        }

        public HttpStatusCode HttpStatusCode
        {
            get => _httpStatusCode;
            set => _httpStatusCode = value;
        }
    }
}
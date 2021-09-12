using System.Net;

namespace backend_api.Models.NoticeBoard.Responses
{
    public class DecreaseEmojiResponse
    {
        public DecreaseEmojiResponse(string status, HttpStatusCode response)
        {
            _status = status;
            _response = response;
        }

        private string _status;
        private HttpStatusCode _response;
        
        public string Status
        {
            get => _status;
            set => _status = value;
        }

        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }
        
    }
}
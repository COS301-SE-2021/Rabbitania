using backend_api.Models.NoticeBoard.Requests;

namespace backend_api.Models.NoticeBoard.Responses
{
    public class AddNoticeBoardThreadResponse
    {
        private string _response;

        public string Response
        {
            get => _response;
            set => _response = value;
        }

        public AddNoticeBoardThreadResponse(string response)
        {
            _response = response;
        }
        
    }
}
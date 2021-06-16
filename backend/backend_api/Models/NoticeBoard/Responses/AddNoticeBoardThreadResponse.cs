using System;
using System.Net;
using backend_api.Models.NoticeBoard.Requests;

namespace backend_api.Models.NoticeBoard.Responses
{
    public class AddNoticeBoardThreadResponse
    {
        private HttpStatusCode _response;

        public HttpStatusCode Response
        {
            get => _response;
            set => _response = value;
        }

        public AddNoticeBoardThreadResponse(HttpStatusCode response)
        {
            _response = response;
        }
        
    }
}
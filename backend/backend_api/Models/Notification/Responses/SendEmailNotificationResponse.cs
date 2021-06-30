using System.Net;

namespace backend_api.Models.Notification.Responses
{
    public class SendEmailNotificationResponse
    {
        private HttpStatusCode _response;

        public SendEmailNotificationResponse(HttpStatusCode response)
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
using System.Net;

namespace backend_api.Models.Notification.Responses
{
    public class CreateNotificationResponse
    {
        private HttpStatusCode _httpStatusCode; 
        
        public CreateNotificationResponse(HttpStatusCode httpStatusCode)
        {
            this._httpStatusCode = httpStatusCode;
        }

        public HttpStatusCode HttpStatusCode
        {
            get => _httpStatusCode;
            set => _httpStatusCode = value;
        }
    }
}
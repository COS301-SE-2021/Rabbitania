namespace backend_api.Models.Notification.Responses
{
    public class CreateNotificationResponse
    {
        private string _message;

        public CreateNotificationResponse(string message)
        {
            this._message = message;
        }

        public string Message
        {
            get => _message;
            set => _message = value;
        }
    }
}
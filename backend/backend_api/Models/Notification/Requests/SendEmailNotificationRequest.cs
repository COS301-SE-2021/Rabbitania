using System.Collections.Generic;

namespace backend_api.Models.Notification.Requests
{
    public class SendEmailNotificationRequest
    {
        private string _payload;
        private string _subject;
        private List<string> _email;

        public SendEmailNotificationRequest(string payload, string subject, List<string> email)
        {
            _payload = payload;
            _subject = subject;
            _email = email;
        }

        public string Payload
        {
            get => _payload;
            set => _payload = value;
        }

        public string Subject
        {
            get => _subject;
            set => _subject = value;
        }

        public List<string> Email
        {
            get => _email;
            set => _email = value;
        }
    }
}
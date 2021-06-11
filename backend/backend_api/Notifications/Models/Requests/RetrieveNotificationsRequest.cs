namespace backend_api.Notifications.Models.Requests
{
    public class RetrieveNotificationRequest
    {
        private int _userId;

        public RetrieveNotificationRequest(int userId)
        {
            this._userId = userId;
        }
        
        public int UserId
        {
            get => _userId;
            set => _userId = value;
        }
    }
}
namespace backend_api.Models.Notification.Requests
{
    public class RetrieveNotificationRequest
    {
        public RetrieveNotificationRequest()
        {
            
        }
        public RetrieveNotificationRequest(int userId)
        {
            this.UserId = userId;
        }
        
        public int UserId { get; set; }
    }
}
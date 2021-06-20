using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Data.Notification;

namespace backend_api.Models.Notification
{
    public class Notification : INotification
    {
        public Notification(string payload, NotificationTypeEnum nType, DateTime date, int userid)
        {
            this.NotificationPayload = payload;
            this.NotificationType = nType;
            this.CreatedDate = date;
            this.UserID = userid;
        }
        
        public Notification()
        {
           
        }
        
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int NotificationId { get; set; }
        
        public string NotificationPayload { get; set; }
        public NotificationTypeEnum NotificationType { get; set; }
        
        public DateTime CreatedDate { get; set; }
        
        // User ID foreign key
        [ForeignKey("User")] 
        public int UserID { get; set; }
    }
}
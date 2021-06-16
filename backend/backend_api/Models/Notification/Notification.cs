using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend_api.Models.Notification
{
    public class Notification : INotification
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int NotificationId { get; set; }
        
        public string NotificationPayload { get; set; }
        public NotificationTypeEnum NotificationType { get; set; }
        public DateTime DateCreated { get; set; }
        
        // User ID foreign key
        [ForeignKey("User")] 
        public int UserID { get; set; }
    }
}
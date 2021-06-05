using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.VisualBasic;

namespace backend_api.Models.Notifications
{
    public class Notification
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int notificationID { get; set; }
        
        public string notificationContent { get; set; }
        
        public NotificationTypeEnum notificationType { get; set; }
        
        public DateTime dateCreated { get; set; }
        
        // User ID foreign key
        [ForeignKey("UserID")] 
        public int UserID { get; set; }

    }
}
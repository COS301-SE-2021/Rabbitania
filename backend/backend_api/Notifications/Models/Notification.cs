using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.Notifications;
using Microsoft.EntityFrameworkCore.ChangeTracking.Internal;
using Microsoft.VisualBasic;

namespace backend_api.Notifications.Models
{
    public class Notification : INotification
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int NotificationId { get; set; }
        
        public string NotificationContent { get; set; }
        
        public NotificationTypeEnum NotificationType { get; set; }
        
        public DateTime DateCreated { get; set; }
        
        // User ID foreign key
        [ForeignKey("UserID")] 
        public int UserId { get; set; }
        
    }
}
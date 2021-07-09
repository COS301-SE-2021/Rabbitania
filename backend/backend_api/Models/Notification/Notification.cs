using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.Notification
{
    public class Notification : INotification
    {
        public Notification(string payload, NotificationTypeEnum nType, DateTime date, int userid)
        {
            this.Payload = payload;
            this.Type = nType;
            this.CreatedDate = date;
            this.UserId = userid;
        }
        
        public Notification()
        {
           
        }
        
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int NotificationId { get; set; }
        
        public string Payload { get; set; }
        public NotificationTypeEnum Type { get; set; }
        
        public DateTime CreatedDate { get; set; }
        
        public int UserId { get; set; }
        public Users User { get; set; }
    }
}
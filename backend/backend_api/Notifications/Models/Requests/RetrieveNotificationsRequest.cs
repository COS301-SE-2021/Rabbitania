using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace backend_api.Notifications.Models.Requests
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
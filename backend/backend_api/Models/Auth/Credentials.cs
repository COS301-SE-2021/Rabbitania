using Microsoft.Build.Framework;

namespace backend_api.Models.Auth
{
    public class Credentials
    {
        [Required]
        public int UserID { get; set; } 
        [Required]
        public string Name { get; set; }
    }
}
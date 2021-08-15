using Microsoft.Build.Framework;

namespace backend_api.Models.Auth
{
    public class Credentials
    {
        [Required]
        public string Email { get; set; }
        [Required]
        public string Name { get; set; }
    }
}
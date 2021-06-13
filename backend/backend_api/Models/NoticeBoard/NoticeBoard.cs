using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.NoticeBoard
{
    public class NoticeBoard
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int threadID { get; set; }

        public string threadTitle { get; set; }

        public string threadContent { get; set; }

        public int minLevel { get; set; }
        
        public string imageUrl { get; set; }
        
        public UserRoles permittedUserRoles { get; set; }
        
        [ForeignKey("User")] 
        public int UserID { get; set; }
        public User.User User { get; set; }
        
       

    }
}
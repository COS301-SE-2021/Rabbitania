using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.NoticeBoard
{
    public class NoticeBoard
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ThreadId { get; set; }

        public string ThreadTitle { get; set; }

        public string ThreadContent { get; set; }

        public int MinEmployeeLevel { get; set; }
        
        public string ImageUrl { get; set; }
        
        public UserRoles PermittedUserRoles { get; set; }
        public int UserId { get; set; }
        public Users User { get; set; }

        public NoticeBoard(string threadTitle, string threadContent, int minLevel, string imageUrl,
            UserRoles permittedUserRoles, int userId)
        {
            ThreadTitle = threadTitle;
            ThreadContent = threadContent;
            MinEmployeeLevel = minLevel;
            ImageUrl = imageUrl;
            PermittedUserRoles = permittedUserRoles;
            UserId = userId;
        }

        public NoticeBoard()
        {
            
        }
    }
}
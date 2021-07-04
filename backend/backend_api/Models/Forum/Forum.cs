using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend_api.Models.Forum
{
    public class Forum : IForum
    {
        public Forum(string forumTitle, int userId, DateTime CreatedDate)
        {
            this.ForumTitle = forumTitle;
            this.UserID = userId;
            this.CreatedDate = CreatedDate;
        }

        public Forum()
        {
            
        }
        
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ForumId { get; set; }
        
        public string ForumTitle { get; set; }
        
        public int UserID { get; set; }

        public DateTime CreatedDate { get; set; }
    }
}
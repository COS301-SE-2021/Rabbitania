using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend_api.Models.Forum
{
    public class ForumThread : IForumThread
    {
        public ForumThread(string ForumThreadTitle, int userId, DateTime CreatedDate, string imageURL, int ForumId)
        {
            this.ForumThreadTitle = ForumThreadTitle;
            this.UserID = userId;
            this.CreatedDate = CreatedDate;
            this.imageURL = imageURL;
            this.ForumId = ForumId;
        }

        public ForumThread()
        {
            
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ForumThreadId { get; set; }

        public string ForumThreadTitle { get; set; }

        public DateTime CreatedDate { get; set; }

        public string imageURL { get; set; }
        
        [ForeignKey("Forum")]
        public int ForumId { get; set; }
        public Forum Forum { get; set; }
        
        [ForeignKey("UserId")]
        public int UserID { get; set; }
        public User.User User { get; set; }
    }
}
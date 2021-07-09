using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.Forum
{
    public class ForumThreads : IForumThread
    {
        public ForumThreads(string ForumThreadTitle, int userId, DateTime CreatedDate, string imageURL, int ForumId)
        {
            this.ForumThreadTitle = ForumThreadTitle;
            this.UserId = userId;
            this.CreatedDate = CreatedDate;
            this.imageURL = imageURL;
            this.ForumId = ForumId;
        }

        public ForumThreads()
        {
            
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ForumThreadId { get; set; }

        public string ForumThreadTitle { get; set; }

        public DateTime CreatedDate { get; set; }

        public string imageURL { get; set; }
        
        [ForeignKey("Forums")]
        public int ForumId { get; set; }
        public Forums Forums { get; set; }
        public int UserId { get; set; }
        public Users User { get; set; }

    }
}
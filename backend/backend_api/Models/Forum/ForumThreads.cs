using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.Forum
{
    public class  ForumThreads : IForumThread
    {
        public ForumThreads(string forumThreadTitle, int userId, DateTime createdDate, string imageUrl, int forumId)
        {
            this.ForumThreadTitle = forumThreadTitle;
            this.UserId = userId;
            this.CreatedDate = createdDate;
            this.imageURL = imageUrl;
            this.ForumId = forumId;
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
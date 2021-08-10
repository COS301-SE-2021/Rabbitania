using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User;

namespace backend_api.Models.Forum
{
    public class  ForumThreads : IForumThread
    {
        public ForumThreads(string forumThreadTitle, int userId, string forumThreadBody, DateTime createdDate, string imageUrl, int forumId)
        {
            this.ForumThreadTitle = forumThreadTitle;
            this.UserId = userId;
            this.ForumThreadBody = forumThreadBody;
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
        public string ForumThreadBody { get; set; }
        public DateTime CreatedDate { get; set; }

        public string imageURL { get; set; }
        
        public int ForumId { get; set; }
        public Forums Forum { get; set; }
        public int UserId { get; set; }
        public Users User { get; set; }

    }
}
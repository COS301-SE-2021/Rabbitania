using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Threading;
using backend_api.Models.User;

namespace backend_api.Models.Forum
{
    public class ThreadComments : IThreadComments
    {
        public ThreadComments(string commentBody, DateTime createdDate, string imageUrl, int likes, int dislikes, int forumThreadId, int userId)
        {
            this.CommentBody = commentBody;
            this.CreatedDate = createdDate;
            this.ImageURL = imageUrl;
            this.Likes = likes;
            this.Dislikes = dislikes;
            this.ForumThreadId = forumThreadId;
            this.UserId = userId;

        }

        public ThreadComments()
        {
            
        }
        
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ThreadCommentId { get; set; }
        public string CommentBody { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ImageURL { get; set; }
        public int Likes { get; set; }
        public int Dislikes { get; set; }
        
        [ForeignKey("ForumThreads")]
        public int ForumThreadId { get; set; }
        public ForumThreads ForumThreads { get; set; }

        
        //UserId will be used to find the user that both created the original comment, and the user to 
        //which the comment is directed at.
        [ForeignKey("UserId")]
        public int UserId { get; set; }
        public Users User { get; set; }
        
        
        
        
    }
}
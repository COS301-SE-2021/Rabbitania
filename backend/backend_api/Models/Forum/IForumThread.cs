using System;

namespace backend_api.Models.Forum
{
    public interface IForumThread
    {
        int ForumThreadId { get; set; }
        string ForumThreadTitle { get; set; }
        /*int UserId { get; set; }*/
        string ForumThreadBody { get; set; }
        DateTime CreatedDate { get; set; }
        string imageURL { get; set; }
        
        int ForumId { get; set; }
    }
}
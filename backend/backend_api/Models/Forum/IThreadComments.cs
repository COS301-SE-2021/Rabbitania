using System;

namespace backend_api.Models.Forum
{
    public interface IThreadComments
    {
        int ThreadCommentId { get; set; }
        string CommentBody { get; set; }
        DateTime CreatedDate { get; set; }
        string ImageURL { get; set; }
        int Likes { get; set; }
        int Dislikes { get; set; }

        
    }
}
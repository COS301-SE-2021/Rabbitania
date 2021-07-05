using System;

namespace backend_api.Models.Forum
{
    public interface IForum
    {
        int ForumId { get; set; }

        string ForumTitle { get; set; }

        /*int UserId { get; set; }*/

        DateTime CreatedDate { get; set; }
    }
}
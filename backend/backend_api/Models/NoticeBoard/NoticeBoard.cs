﻿using System.ComponentModel.DataAnnotations;
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

        public int MinLevel { get; set; }
        
        public string ImageUrl { get; set; }
        
        public UserRoles PermittedUserRoles { get; set; }
        
        [ForeignKey("User")] 
        public int UserId { get; set; }

        public NoticeBoard(string threadTitle, string threadContent, int minLevel, string imageUrl,
            UserRoles permittedUserRoles, int userId)
        {
            ThreadTitle = threadTitle;
            ThreadContent = threadContent;
            MinLevel = minLevel;
            ImageUrl = imageUrl;
            PermittedUserRoles = permittedUserRoles;
            UserId = userId;
        }

        public NoticeBoard()
        {
            
        }
    }
}
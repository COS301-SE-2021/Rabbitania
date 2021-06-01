using System.Collections;
using System.Collections.Generic;
using backend_api.Models;

namespace backend_api.Models
{
    public class NoticeBoard
    {
        public List<NoticeBoardThread> threads;
        public string title { get; set; }
        public List<UserRole> permittedUserRoles { get; set; }
    }
}
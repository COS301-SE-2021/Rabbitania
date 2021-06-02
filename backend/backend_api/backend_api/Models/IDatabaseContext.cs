using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace backend_api.Models
{
    public interface IDatabaseContext
    {
        DbSet<User> users { get; set; }
        DbSet<UserEmails> userEmails { get; set; }
        DbSet<NoticeBoardThread> noticeBoardThreads { get; set; }
        DbSet<NoticeBoard> noticeBoard { get; set; }
        Task<int> SaveChanges();
    }
}
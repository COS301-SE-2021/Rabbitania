using System.Threading.Tasks;
using backend_api.Models.Forum;
using backend_api.Models.User;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Forum
{
    public interface IForumContext
    {
        DbSet<Forums> Forums { get; set; }
        DbSet<ForumThreads> ForumThreads { get; set; }
        DbSet<ThreadComments> ThreadComments { get; set; }
        Task<int> SaveChanges();
    }
}

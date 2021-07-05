using System.Threading.Tasks;
using backend_api.Models.Forum;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Forum
{
    public interface IForumContext
    {
        DbSet<Models.Forum.Forum> Forums { get; set; }
        DbSet<ForumThread> ForumThreads { get; set; }
        Task<int> SaveChanges();
    }
}

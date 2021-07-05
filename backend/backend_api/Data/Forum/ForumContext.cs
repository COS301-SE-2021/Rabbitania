using System.Threading.Tasks;
using backend_api.Models.Forum;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Forum
{
    public class ForumContext : DbContext, IForumContext
    {
        
        public ForumContext(DbContextOptions<ForumContext> options) : base(options)
        {

        }

        public ForumContext()
        {
            
        }
        
        public DbSet<Models.Forum.Forums> Forums { get; set; }
        public DbSet<ForumThreads> ForumThreads { get; set; }

        public new async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        } 
    }
}
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.NoticeBoard
{
    public class NoticeBoardContext : DbContext, INoticeBoardContext
    {
        
        public NoticeBoardContext(DbContextOptions<NoticeBoardContext> options) : base(options)
        {

        }

        public NoticeBoardContext()
        {
            
        }
        
        public DbSet<Models.NoticeBoard.NoticeBoard> NoticeBoard { get; set; }

        public async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
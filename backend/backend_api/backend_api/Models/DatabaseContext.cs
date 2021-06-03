using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Notifications;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Models
{
    public class DatabaseContext : DbContext, IDatabaseContext
    {
        
        public DatabaseContext(DbContextOptions options) : base(options)
        {

        }

        public DatabaseContext()
        {
           
        }
        public DbSet<User> users { get; set; }
        public DbSet<Notification> notifications { get; set; }
        public DbSet<UserEmails> userEmails { get; set; }
        public DbSet<NoticeBoardThread> noticeBoardThreads { get; set; }
        
        public DbSet<NoticeBoard> noticeBoard { get; set; }
        
        // Creating Seed Mock Data for Users
        
        public async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
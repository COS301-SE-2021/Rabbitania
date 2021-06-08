using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Notifications;
using backend_api.User.Models.User;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Models
{
    public class DatabaseContext : DbContext, IDatabaseContext
    {
        private List<int> listOfMockIds;
        public DatabaseContext(DbContextOptions options) : base(options)
        {

        }

        public DatabaseContext()
        {
            listOfMockIds = new List<int>();
            listOfMockIds.Add(1);
            listOfMockIds.Add(4);
        }
        
        public DbSet<User.Models.User.User> users { get; set; }
        public DbSet<Notification> notifications { get; set; }
        public DbSet<UserEmails> userEmails { get; set; }
        public DbSet<NoticeBoardThread> noticeBoardThreads { get; set; }
        
        public DbSet<NoticeBoard> noticeBoard { get; set; }
        
        // Creating Seed Mock Data for User

        public async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
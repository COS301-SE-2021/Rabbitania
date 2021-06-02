using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Notifications;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Models
{
    public class DatabaseContext : DbContext, IDatabaseContext
    {
        //private readonly List<int> mockIDs;
        public DatabaseContext(DbContextOptions options) : base(options)
        {

        }

        public DatabaseContext()
        {
            //this.mockIDs = new List<int>();
            //this.mockIDs.Add(1);
            //this.mockIDs.Add(2);
        }
        public DbSet<Notification> notifications { get; set; }
        
        public async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
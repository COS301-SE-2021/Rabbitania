using System.Threading.Tasks;
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

        public async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
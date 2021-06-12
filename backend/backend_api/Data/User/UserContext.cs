using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.User
{
    public class UserContext: DbContext, IUserContext
    {
        public UserContext(DbContextOptions options) : base(options)
        {
            
        }

        public UserContext()
        {
            
        }
        public DbSet<Models.User.User> users { get; set; }

        public async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}

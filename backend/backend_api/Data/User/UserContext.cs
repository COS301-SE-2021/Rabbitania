using System.Threading.Tasks;
using backend_api.Models.User;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.User
{
    public class UserContext: DbContext, IUserContext
    {
        public UserContext(DbContextOptions<UserContext> options) : base(options)
        {
            
        }

        public UserContext()
        {
            
        }
        public DbSet<Models.User.Users> Users { get; set; }
        
        public DbSet<UserEmails> UserEmail { get; set; }
        public async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}

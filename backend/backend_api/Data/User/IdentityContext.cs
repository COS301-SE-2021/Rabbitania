using System.Threading.Tasks;
using backend_api.Models.User;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.User
{
    public class IdentityContext : DbContext, IUserContext
    {
        public IdentityContext(DbContextOptions<IdentityContext> options) : base(options)
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
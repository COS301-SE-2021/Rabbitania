using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.User
{
    public class UserEmailsContext: DbContext, IUserEmailsContext
    {
        public UserEmailsContext(DbContextOptions options) : base(options)
        {
            
        }

        public UserEmailsContext()
        {
            
        }
        public DbSet<Models.User.UserEmails> emails { get; set; }

        public async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
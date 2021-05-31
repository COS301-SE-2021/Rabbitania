using Microsoft.EntityFrameworkCore;
using backend_api.Models;

namespace backend_api.Models
{
    public class RepositoryContext: DbContext
    {
        public RepositoryContext(DbContextOptions options)
                    :base(options){}
        
        public DbSet<User> users { get; set; }
        //other table dBsets go here

    }
}
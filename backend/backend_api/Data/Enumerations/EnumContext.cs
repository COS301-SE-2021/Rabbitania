using backend_api.Data.Booking;
using System.Threading.Tasks;
using backend_api.Models.Enumerations;
using backend_api.Models.Enumerations.OfficeLocations;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Enumerations
{
    public class EnumContext: DbContext, IEnumContext
    {
        public EnumContext(DbContextOptions<EnumContext> options) : base(options)
        {

        }

        public EnumContext()
        {
            
        }
        
        public DbSet<OfficeLocations> OfficeLocations { get; set; }
        
        //public DbSet<UserRolesModel> UserRoles { get; set; }

        public new async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
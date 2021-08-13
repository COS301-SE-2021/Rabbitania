using System.Threading.Tasks;
using backend_api.Models.Enumerations;
using backend_api.Models.Enumerations.OfficeLocations;
using backend_api.Models.Enumerations.UserRole;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Enumerations
{
    public interface IEnumContext
    {
        public DbSet<OfficeLocations> OfficeLocations { get; set; }

        public DbSet<UsersRoles> UsersRoles { get; set; }

        Task<int> SaveChanges();
    }
}
using System.Threading.Tasks;
using backend_api.Models.Enumerations;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Enumerations
{
    public interface IEnumContext
    {
        public DbSet<OfficeLocationModel> OfficeLocations { get; set; }

        public DbSet<UserRolesModel> UserRoles { get; set; }

        Task<int> SaveChanges();
    }
}
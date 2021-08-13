using System.Threading.Tasks;
using backend_api.Models.Enumerations;
using backend_api.Models.Enumerations.OfficeLocations;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Enumerations
{
    public interface IEnumContext
    {
        public DbSet<OfficeLocations> OfficeLocations { get; set; }

        //public DbSet<UserRolesModel> UserRoles { get; set; }

        Task<int> SaveChanges();
    }
}
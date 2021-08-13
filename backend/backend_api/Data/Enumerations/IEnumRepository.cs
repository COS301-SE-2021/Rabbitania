using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Enumerations;

namespace backend_api.Data.Enumerations
{
    public interface IEnumRepository
    {
        Task<OfficeLocationModel> GetOfficeName();
        
        Task<UserRolesModel> GetUserRoleType();
    }
}